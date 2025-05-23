local set_keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

set_keymap("n", "<C-d>", "<C-d>zz", opts)      -- move down and center view
set_keymap("n", "<C-u>", "<C-u>zz", opts)      -- move up and center view
set_keymap("n", "n", "nzzzv", opts)            -- Select next from search
set_keymap("n", "N", "Nzzzv", opts)            -- Select previous from search
set_keymap("n", "<leader>e", vim.cmd.Ex, opts) -- Open file browser
set_keymap("n", "J", "mzJ`z", opts)            -- Join lines and keep cursor position
set_keymap("v", "J", ":m '>+1<CR>gv=gv", opts) -- Move selection down
set_keymap("v", "K", ":m '<-2<CR>gv=gv", opts) -- Move selection down
set_keymap("x", "<leader>p", "\"_dP", opts)    -- paste without overriding
set_keymap("v", "<", "<gv", opts)
set_keymap("v", ">", ">gv", opts)
