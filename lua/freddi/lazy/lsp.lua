return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp',
            {
                "folke/lazydev.nvim",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },

        -- Add hover.nvim for live LSP previews
        {
            "lewis6991/hover.nvim",
            config = function()
                require("hover").setup {
                    init = function()
                        -- Setup keymaps
                        require("hover.providers.lsp")
                    end,
                    preview_opts = {
                        border = "single"
                    },
                    -- Display LSP hover documentation in preview window
                    preview_window = true,
                    title = true,
                    mouse_providers = {
                        "LSP"
                    },
                    mouse_delay = 1000,
                }

                vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
                vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
                vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
                vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, {desc = "hover.nvim (next source)"})
            end,
        },

        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig").lua_ls.setup { capabilities = capabilities }
            require("lspconfig").pylsp.setup { capabilities = capabilities }

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local c = vim.lsp.get_client_by_id(args.data.client_id)
                    if not c then return end

                    -- Enable hover preview on cursor hold
                    vim.api.nvim_create_autocmd("CursorHold", {
                        buffer = args.buf,
                        callback = function()
                            require("hover").hover()
                        end
                    })

                    if vim.bo.filetype == "lua" then
                        -- Format the current buffer on save
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
                            end,
                        })
                    end
                end,
            })
        end,
    }
}

-- -- Adapted from a combo of
-- -- https://lsp-zero.netlify.app/v3.x/blog/theprimeagens-config-from-2022.html
-- -- https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/lazy/lsp.lua
-- return {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "williamboman/mason.nvim",
--         "williamboman/mason-lspconfig.nvim",
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-buffer",
--         "hrsh7th/cmp-path",
--         "hrsh7th/cmp-cmdline",
--         "hrsh7th/nvim-cmp",
--         "L3MON4D3/LuaSnip",
--         "saadparwaiz1/cmp_luasnip",
--         "j-hui/fidget.nvim",
--     },
--     config = function()
--         local cmp_lsp = require("cmp_nvim_lsp")
--         local capabilities = vim.tbl_deep_extend(
--             "force",
--             {},
--             vim.lsp.protocol.make_client_capabilities(),
--             cmp_lsp.default_capabilities()
--         )
--
--         require("fidget").setup({})
--         require("mason").setup()
--
--         require('mason-lspconfig').setup({
--             ensure_installed = {
--                 "lua_ls",
--                 "pyright",
--             },
--             handlers = {
--                 function(server_name)
--                     require('lspconfig')[server_name].setup({
--                         capabilities = capabilities,
--                     })
--                 end,
--                 ["lua_ls"] = function()
--                     require('lspconfig').lua_ls.setup({
--                         capabilities = capabilities,
--                         settings = {
--                             Lua = {
--                                 runtime = {
--                                     version = 'LuaJIT'
--                                 },
--                                 diagnostics = {
--                                     globals = { 'vim', 'love' },
--                                 },
--                                 workspace = {
--                                     library = {
--                                         vim.env.VIMRUNTIME,
--                                     }
--                                 }
--                             }
--                         }
--                     })
--                 end,
--                 ["pyright"] = function()
--                     require("lspconfig").pyright.setup({
--                         capabilities = capabilities,
--                         settings = {
--                             python = {
--                                 analysis = {
--                                     -- typeCheckingMode = "strict",
--                                     -- autoSearchPaths = true,
--                                     -- useLibraryCodeForTypes = true,
--                                 }
--                             }
--                         }
--
--                     })
--                 end
--             }
--         })
--
--         local cmp = require('cmp')
--         local cmp_select = { behavior = cmp.SelectBehavior.Select }
--         local luasnip = require("luasnip")
--
--         -- this is the function that loads the extra snippets to luasnip
--         -- from rafamadriz/friendly-snippets
--         require('luasnip.loaders.from_vscode').lazy_load()
--
--         cmp.setup({
--             sources = {
--                 { name = 'path' },
--                 { name = 'nvim_lsp' },
--                 { name = 'luasnip', keyword_length = 2 },
--                 { name = 'buffer',  keyword_length = 3 },
--             },
--             mapping = cmp.mapping.preset.insert({
--                 ['<C-n>'] = cmp.mapping.select_next_item(),
--                 ['<C-p>'] = cmp.mapping.select_prev_item(),
--                 ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--                 ['<C-f>'] = cmp.mapping.scroll_docs(4),
--                 ['<C-Space>'] = cmp.mapping.complete {},
--                 ['<CR>'] = cmp.mapping.confirm {
--                     behavior = cmp.ConfirmBehavior.Replace,
--                     select = true,
--                 },
--                 ['<Tab>'] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         cmp.select_next_item()
--                     elseif luasnip.expand_or_locally_jumpable() then
--                         luasnip.expand_or_jump()
--                     else
--                         fallback()
--                     end
--                 end, { 'i', 's' }),
--                 ['<S-Tab>'] = cmp.mapping(function(fallback)
--                     if cmp.visible() then
--                         cmp.select_prev_item()
--                     elseif luasnip.locally_jumpable(-1) then
--                         luasnip.jump(-1)
--                     else
--                         fallback()
--                     end
--                 end, { 'i', 's' })
--             }),
--             snippet = {
--                 expand = function(args)
--                     require('luasnip').lsp_expand(args.body)
--                 end,
--             },
--             window = {
--                 documentation = {
--                     border = 'rounded',
--                 },
--                 completion = { -- rounded border
--                     border = 'rounded',
--                 },
--             }
--         })
--     end
-- }
