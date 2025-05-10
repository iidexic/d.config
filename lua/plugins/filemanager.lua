local M = {}

M.plugins = {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      {
        '\\',
        ':Neotree toggle=true<CR>',
        --[[function() require('neo-tree.command').execute {'toggle'} end,--]]
        desc = 'NeoTree toggle',
        --silent = true,
      },
    },
    opts = {
      filesystem = {
        window = {
          mappings = { ['l'] = 'open' }, --or: ['l'] = {command = 'open', nowait = true}
        },
      },
    },
  },
  --[[ nah
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
--]]
}

return M.plugins
