-- Adapted from a combo of
-- https://lsp-zero.netlify.app/v3.x/blog/theprimeagens-config-from-2022.html
-- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/lazy/lsp.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"stevearc/conform.nvim",
	},
	config = function()
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)
		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"clangd",
				"ruff",
			},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				lua_ls = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
								},
								diagnostics = {
									globals = { "vim", "love" },
								},
								workspace = {
									library = {
										vim.env.VIMRUNTIME,
									},
								},
							},
						},
					})
				end,
				pyright = function()
					require("lspconfig").pyright.setup({
						capabilities = capabilities,
						settings = {
							python = {
								analysis = {
									typeCheckingMode = "basic",
									autoSearchPaths = true,
									useLibraryCodeForTypes = true,
									diagnosticMode = "workspace",
								},
							},
						},
					})
				end,
				clangd = function()
					require("lspconfig").clangd.setup({
						capabilities = capabilities,
						cmd = {
							"clangd",
							"--background-index",
							"--clang-tidy",
							"--header-insertion=iwyu",
							"--completion-style=detailed",
							"--function-arg-placeholders",
						},
						init_options = {
							clangdFileStatus = true,
							usePlaceholders = true,
							completeUnimported = true,
							semanticHighlighting = true,
						},
					})
				end,
			},
		})

		-- Configure conform.nvim for formatting
		require("conform").setup({
			formatters_by_ft = {
				python = { "isort", "black" },
				cpp = { "clang_format" },
				c = { "clang_format" },
			},
			formatters = {
				black = {
					prepend_args = { "--line-length", "120" },
				},
				isort = {
					prepend_args = { "--profile", "black", "--line-length", "120" },
				},
				clang_format = {
					prepend_args = { "--style={ColumnLimit: 120}" },
				},
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		-- Set up flake8 diagnostics (using efm-langserver or null-ls alternative)
		-- Note: You'll need to install flake8 via Mason or system package manager
		-- and configure it to use 120 character line length in your project's
		-- .flake8 or setup.cfg file:
		-- [flake8]
		-- max-line-length = 120

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		-- this is the function that loads the extra snippets to luasnip
		-- from rafamadriz/friendly-snippets
		require("luasnip.loaders.from_vscode").lazy_load()
		cmp.setup({
			sources = {
				{ name = "path" },
				{ name = "nvim_lsp" },
				{ name = "luasnip", keyword_length = 2 },
				{ name = "buffer", keyword_length = 3 },
			},
			mapping = cmp.mapping.preset.insert({
				-- ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				-- ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				-- ['<C-Space>'] = cmp.mapping.complete(),
			}),
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
		})
	end,
}
