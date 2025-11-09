local M = {}

M.plugins = {
  { -- lspsaga provides much nicer lsp interactivity and visualization
    'nvimdev/lspsaga.nvim',
    opts = {
      symbol_in_winbar = {
        enabled = false,
      },
      ui = {
        code_action = 'ﯦ',
      },
      LightBulb = {
        virtual_text = false,
      },

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

M.setup = function()
  local lspsaga = require 'lspsaga'
  lspsaga.config.symbol_in_winbar.enabled = true
  lspsaga.config.lightbulb.virtual_text = false
end

return M
