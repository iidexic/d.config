local M = {}

M.plugins = {
  {
    'lewis6991/hover.nvim',
    config = function()
      require('hover').setup {
        init = function()
          -- Require providers
          require 'hover.providers.lsp'
          -- require('hover.providers.gh')
          -- require('hover.providers.gh_user')
          -- require('hover.providers.jira')
          require 'hover.providers.dap'
          -- require('hover.providers.fold_preview')
          require 'hover.providers.diagnostic'
          -- require('hover.providers.man')
          --require 'hover.providers.dictionary'
          -- require('hover.providers.highlight')
        end,
        preview_opts = {
          border = 'none', -- same as vim hover, 'single', 'shadow', etc. still not great
          --height, width
          max_height = 20,
          max_width = 120,
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = true,
        title = true,

        mouse_providers = {
          'LSP',
        },
        mouse_delay = 1000,
      }
    end,
  },
}

return M
