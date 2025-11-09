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
        silent = true,
      },
    },
    opts = {
      filesystem = {
        hide_hidden = false,
        hide_by_name = {
          '.git',
          '.gitignore',
        },
        window = {
          mappings = { ['l'] = 'open' }, --or: ['l'] = {command = 'open', nowait = true}
        },
      },
    },
    --NOTE: Alternative opts (via function) for pymple to get neo-tree filename updates/etc.
    --[[ opts = function(_, opts)
      local api = require 'pymple.api'
      local config = require 'pymple.config'

      local function on_move(args)
        api.update_imports(args.source, args.destination, config.user_config.update_imports)
      end

      local events = require 'neo-tree.events'
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
    end, ]]
  },
}

return M.plugins
