return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Keybindings
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        -- Add current file to Harpoon
        keymap("n", "<leader>ha", function() harpoon:list():add() end, opts)

        -- Toggle the Harpoon UI
        keymap("n", "<leader>hu", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, opts)

        -- Navigate to Harpoon file 1-4
        keymap("n", "<leader>1", function() harpoon:list():select(1) end, opts)
        keymap("n", "<leader>2", function() harpoon:list():select(2) end, opts)
        keymap("n", "<leader>3", function() harpoon:list():select(3) end, opts)
        keymap("n", "<leader>4", function() harpoon:list():select(4) end, opts)
    end,
}
