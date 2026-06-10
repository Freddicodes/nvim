
vim.g.mapleader = " "
vim.o.expandtab = true
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.updatetime = 50
vim.o.winborder = "rounded"
vim.o.wrap = false
vim.opt.clipboard = "unnamedplus"

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.lsp.config['lua_ls'] = {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },

  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
}

vim.lsp.config['basedpyright'] = {
  cmd = { 'basedpyright-langserver', '--stdio' },

  filetypes = { 'python' },

  root_markers = {
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    '.git',
  },

  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic',
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

vim.lsp.enable('lua_ls')
vim.lsp.enable('basedpyright')


vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim", name = "tokyonight" }
})

vim.cmd.colorscheme "tokyonight"

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" }
})

require("nvim-treesitter").setup {
    ensure_installed = {"lua", "cpp", "python" },
    sync_install = {},
    auto_install = {},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

vim.pack.add({
    'https://github.com/saghen/blink.lib',
    'https://github.com/saghen/blink.cmp'
})

local blink = require("blink.cmp")

if pcall(require, "blink.cmp") == 0 then
    blink.build():pwait()
end

blink.setup({
    keymap = {
        preset = "default",
        ["<Tab>"] = { "accept" },
    },
    appearance = {
        nerd_font_variant = "mono",
    },
    completion = {
        documentation = { auto_show = true },
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "rust" },
})

vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local builtin = require('telescope.builtin')

require('telescope').setup({
	pickers = {
		buffers = {
			initial_mode = "normal",
		},
		bookmarks = {
			initial_mode = "normal",
		},
	},
})

function SearchClasses()
	builtin.lsp_workspace_symbols({
		query = { "Class" },
		prompt_title = "Search Classes"
	})
end

function SearchFunctions()
	builtin.lsp_dynamic_workspace_symbols({
		query = { "Function", "Method" },
		prompt_title = "Search Functions"
	})
end

function SearchVariables()
	builtin.lsp_dynamic_workspace_symbols({
		query = { "Variable", "Constant" },
		prompt_title = "Search Variables"
	})
end


vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
})
require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},
	formatters_by_ft = {
		lua = { "stylua" },
		json = { "jq" },
		rust = { "rustfmt" },
		python = { "black" },
		htmldjango = { "djlint" },
		html = { "djlint" },
		javascript = { "prettier" },
	},
})

--: oil
vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim.git" },
})
require('oil').setup()

--: diffview
vim.pack.add({
	{ src = "https://github.com/sindrets/diffview.nvim" },
})


vim.keymap.set('v', '<', '<gv', { noremap = true, desc = "Indent left and keep selection" })
vim.keymap.set('v', '>', '>gv', { noremap = true, desc = "Indent right and keep selection" })

vim.keymap.set('n', '<leader>x', [[:cclose<CR>]], { desc = "Close quickfix list" })

vim.keymap.set('n', '<leader>ge', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '<leader>gE', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

vim.keymap.set('n', '<leader>sn', ":cnext<CR>", { noremap = true, desc = "Next quickfix item" })
vim.keymap.set('n', '<leader>sp', ":cprev<CR>", { noremap = true, desc = "Previous quickfix item" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf, noremap = true, silent = true }

    vim.bo[args.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})

vim.keymap.set('n', '<leader>sF', builtin.find_files, { desc = "Find files" })
vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = "Live grep" })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = "Buffers" })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = "Help tags" })
vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = "Keymaps" })
-- vim.keymap.set('n', '<C-e>', builtin.oldfiles, {})
-- vim.keymap.set('n', '<leader>sg', builtin.git_files, {})
vim.keymap.set('n', '<leader>sf', SearchFunctions, {})
vim.keymap.set('n', '<leader>sc', SearchClasses, {})
vim.keymap.set('n', '<leader>sv', SearchVariables, {})
-- vim.keymap.set('n', 'gb', ":Telescope buffers<CR>", { desc = '[G]oto [B]uffer' })
-- vim.keymap.set('n', '<leader>ss', builtin.lsp_dynamic_workspace_symbols, {})
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sq', builtin.quickfix, {})

vim.keymap.set('n', '<leader>e', "<CMD>Oil<CR>", { desc = "Open Oil file explorer" })
