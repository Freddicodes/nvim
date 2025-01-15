return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'catppuccin/nvim',
    },
    config = function()
      vim.cmd.colorscheme("catppuccin")
      vim.opt.termguicolors = true
      require('bufferline').setup {}
    end
  }