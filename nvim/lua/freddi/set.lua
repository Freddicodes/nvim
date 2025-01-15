-- set leader
vim.g.mapleader = ' '

vim.cmd.colorscheme("catppuccin")

vim.opt.clipboard = "unnamedplus" -- use system keyboard for yank

vim.opt.nu = true                 -- set line numbers
vim.opt.relativenumber = true     -- user relative line numbers

vim.opt.signcolumn = 'yes'
vim.o.cursorline = true

-- set tab size to 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.incsearch = true -- incremental search

vim.opt.termguicolors = true

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = "menuone,noselect"

--  Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})
