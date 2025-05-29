local M = {}

M.plugins = {
  { --good but I don't use telescope file brows and it disrupts my binds
    'startup-nvim/startup.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      require('startup').setup()
    end,
    cond = false,
  },
}

return M.plugins
