return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup(
        {
          filters = {
            dotfiles = false,
            git_ignored = false
          },
          actions = { -- close the tree on file open
            open_file = {
              quit_on_open = true,
            }
          }
        })
       -- Close nvim-tree when quitting Neovim
       vim.api.nvim_create_autocmd("QuitPre", {
          callback = function()
              local api = require("nvim-tree.api")
              api.tree.close()
          end,
        })
    end,
  }