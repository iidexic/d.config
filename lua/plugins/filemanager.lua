local M = {}

M.plugins = {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    opts = {
      filesystem = {
        hide_hidden = false,
        hide_by_name = {
          '.git',
          '.gitignore',
        },
        window = {
          mappings = { ['l'] = { command = 'open', nowait = true } },
        },
      },
    },
  },
}

return M.plugins
