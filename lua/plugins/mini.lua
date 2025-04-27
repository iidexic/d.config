return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.files').setup {
        opts = {},
        --using keys here doesn't work for some reason
        --keys = { { '<leader>af', '<cmd>lua MiniFiles.open()<cr>', desc = '[A]pp: Mini[F]iles' } },
      } --> start of my additions
      vim.keymap.set('n', '<leader>af', '<cmd>lua MiniFiles.open()<cr>')
      require('mini.icons').setup() -- for mini.files specifically
      require('mini.surround').setup()
      require('mini.jump2d').setup {
        -- function 4 producing jump spots. (:help MiniJump2d.start)
        spotter = nil, -- nil = MiniJump2d.default_spotter
        labels = 'abcdefghijklmnopqrstuvwxyz',
        view = { -- Options for visual effects
          dim = false, -- Whether to dim lines with at least one jump spot
          n_steps_ahead = 0, -- How many steps ahead to show. Set to big number to show all steps.
        },
        -- lines allowed to place spots. cursor_before = up, cursor_after = down.
        allowed_lines = { blank = true, fold = true, cursor_before = true, cursor_at = true, cursor_after = true },
        allowed_windows = { current = true, not_current = true }, -- toggle jump between window
        -- Functions to be executed at certain events
        hooks = { before_start = nil, after_jump = nil },
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = { start_jumping = '<M-CR>' },

        silent = false, -- toggle non-error feedback. also affects idle helper messages when user input required.
      }
      require('mini.bufremove').setup()

      local tabline = require 'mini.tabline'
      tabline.setup { use_icons = vim.g.have_nerd_font }

      local statusline = require 'mini.statusline' -- Simple and easy statusline.
      statusline.setup { use_icons = vim.g.have_nerd_font } -- set use_icons to true if you have a Nerd Font
      -- default behavior.
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() -- configure statusline sections by overriding their default behavior
        return '%2l:%-2v' -- Ex: here we set the section for cursor location to LINE:COLUMN
      end
    end, -- and there is more! Check out: https://github.com/echasnovski/mini.nvim
  },
}
