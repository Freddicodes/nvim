local wk = require "which-key"
local builtin = require('telescope.builtin')

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*",
--     command = [[%s/\s\+$//e]],
-- })

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
    callback = function(event)
        local opts = { buffer = event.buf }

        -- Updated LSP mappings using the correct format
        local mappings = {
            { "gd",         vim.lsp.buf.definition,       desc = "Go to definition",          mode = "n" },
            { "gl",         vim.diagnostic.open_float,    desc = "Open diagnostic float",     mode = "n" },
            { "<leader>bf", vim.lsp.buf.format,           desc = "Format current buffer",     mode = "n" },
            { "K",          vim.lsp.buf.hover,            desc = "Show hover information",    mode = "n" },
            { "<leader>la", vim.lsp.buf.code_action,      desc = "Code action",               mode = "n" },
            { "<leader>lr", vim.lsp.buf.references,       desc = "References",                mode = "n" },
            { "<leader>ln", vim.lsp.buf.rename,           desc = "Rename",                    mode = "n" },
            { "<leader>lw", vim.lsp.buf.workspace_symbol, desc = "Workspace symbol",          mode = "n" },
            { "<leader>ld", vim.diagnostic.open_float,    desc = "Open diagnostic float",     mode = "n" },
            { "[d",         vim.diagnostic.goto_next,     desc = "Go to next diagnostic",     mode = "n" },
            { "]d",         vim.diagnostic.goto_prev,     desc = "Go to previous diagnostic", mode = "n" },
        }

        wk.add(mappings, opts)

        -- Format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = event.buf,
            callback = function()
                vim.lsp.buf.format { async = false, id = event.data.client_id }
            end
        })
    end,
})


-- local wk = require("which-key")
-- wk.add({
--   { "<leader>f", group = "file" }, -- group
--   { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
--   { "<leader>fb", function() print("hello") end, desc = "Foobar" },
--   { "<leader>fn", desc = "New File" },
--   { "<leader>f1", hidden = true }, -- hide this keymap
--   { "<leader>w", proxy = "<c-w>", group = "windows" }, -- proxy to window mappings
--   { "<leader>b", group = "buffers", expand = function()
--       return require("which-key.extras").expand.buf()
--     end
--   },
--   {
--     -- Nested mappings are allowed and can be added in any order
--     -- Most attributes can be inherited or overridden on any level
--     -- There's no limit to the depth of nesting
--     mode = { "n", "v" }, -- NORMAL and VISUAL mode
--     { "<leader>q", "<cmd>q<cr>", desc = "Quit" }, -- no need to specify mode since it's inherited
--     { "<leader>w", "<cmd>w<cr>", desc = "Write" },
--   }
-- })


-- tmux Nvim navigation
wk.add({
    { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>",  desc = "Move cursor to the LEFT", mode = "n" },
    { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>",  desc = "Move cursor to the DOWN", mode = "n" },
    { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>",    desc = "Move cursor to UP",       mode = "n" },
    { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "Move cursor RIGHT",       mode = "n" },

})

-- mappings for the harpoon plugin
local harpoon = require("harpoon")
wk.add({
    {
        "<leader>ha",
        function()
            harpoon:list():add(); print("Add file to harpoon")
        end,
        desc = "Add current buffer to Harpoon list",
        mode = "n"
    },
    { "<leader>hu", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle Harpoon quick menu",              mode = "n" },
    { "<leader>1",  function() harpoon:list():select(1) end,                     desc = "Select buffer 1 from Harpoon list",      mode = "n" },
    { "<leader>2",  function() harpoon:list():select(2) end,                     desc = "Select buffer 2 from Harpoon list",      mode = "n" },
    { "<leader>3",  function() harpoon:list():select(3) end,                     desc = "Select buffer 3 from Harpoon list",      mode = "n" },
    { "<leader>4",  function() harpoon:list():select(4) end,                     desc = "Select buffer 4 from Harpoon list",      mode = "n" },
    { "<leader>hp", function() harpoon:list():prev() end,                        desc = "Select previous buffer in Harpoon list", mode = "n" },
    { "<leader>hn", function() harpoon:list():next() end,                        desc = "Select next buffer in Harpoon list",     mode = "n" },
})

-- Updated non-LSP mappings using the correct format
wk.add({
    -- Improved default keymaps
    { "<C-d>", "<C-d>zz", desc = "Move down and center view",   mode = "n" },
    { "<C-u>", "<C-u>zz", desc = "Move up and center view",     mode = "n" },
    { "n",     "nzzzv",   desc = "Select next from search",     mode = "n" },
    { "N",     "Nzzzv",   desc = "Select previous from search", mode = "n" },
    -- { "n", "<leader>e", vim.cmd.Ex, desc = "Open file explorer" },
    -- { "n", "<leader>p", "\"_dP", desc = "Paste without overwrite" },
    -- { "n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment" },
    -- { "n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Search and replace word under cursor" },
    -- { "n", "<leader>t", ":Today<CR>", desc = "Open today's note" },
    -- { "n", "J", "mzJ`z", desc = "Join lines and keep cursor position" },
    -- { "n", "<C-d>", "<C-d>zz", desc = "Half page down and center" },
    -- { "n", "<C-u>", "<C-u>zz", desc = "Half page up and center" },
    -- { "n", "n", "nzzzv", desc = "Next search result and center" },
    -- { "n", "N", "Nzzzv", desc = "Previous search result and center" },
    -- { "n", "Q", "<nop>", desc = "Disable Ex mode" },
})

-- Updated Telescope mappings using the correct format
wk.add({
    { "<leader>sf", builtin.find_files, desc = "Find files",     mode = "n" },
    { "<leader>fg", builtin.git_files,  desc = "Find git files", mode = "n" },
    { "<leader>sw", builtin.live_grep,  desc = "Live grep",      mode = "n" },
    { "<leader>sb", builtin.buffers,    desc = "Find buffers",   mode = "n" },
    { "<leader>sk", builtin.keymaps,    desc = "Find keymaps",   mode = "n" },
})

-- Updated Visual mode mappings using the correct format
wk.add({
    { "J",         ":m '>+1<CR>gv=gv",                       desc = "Move selection down", mode = "v" },
    { "K",         ":m '<-2<CR>gv=gv",                       desc = "Move selection up",   mode = "v" },
    { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", desc = "Toggle comment",      mode = "v" },
})


-- File tree mappings
wk.add({
    { "<leader>to", "<CMD>NvimTreeFocus<CR>",  desc = "Move selection down", mode = "n" },
    { "<leader>tc", "<CMD>NvimTreeToggle<CR>", desc = "Move selection down", mode = "n" },
})

-- Keep the insert mode right arrow behavior
-- vim.keymap.set('i', '<Right>', '<Right>', { noremap = true })
