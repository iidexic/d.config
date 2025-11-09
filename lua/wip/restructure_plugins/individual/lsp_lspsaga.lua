local M = {}

M.plugins = {
  { -- lspsaga provides much nicer lsp interactivity and visualization
    'nvimdev/lspsaga.nvim',
    opts = {

      outline = {
        win_position = 'left',
        win_width = 36,
      },
    },
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },
}

return M
