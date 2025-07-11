return {
  --==(ENABLED:)==--
  --> |mini.ai| [ check if covered by another workflow plugin ]
  --> |mini.files|
  --> |mini.icons| (exclusively for mini.files)
  --> |mini.surround| [ check if  covered by another workflow plugin ]
  --> |mini.jump2d| [ may be replaced by leap+extensions ]
  --> |mini.bufremove|
  --> |mini.tabline|
  --> |mini.statusline|
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.align').setup()
      require('mini.files').setup {
        options = {},
        windows = {
          max_number = math.huge, -- Maximum number of windows to show side by side
          preview = false, -- Whether to show preview of file/directory under cursor
          width_focus = 50, -- Width of focused window
          width_nofocus = 15, -- Width of non-focused window
          width_preview = 25, -- Width of preview window
        },
      }
      require('mini.icons').setup() -- for mini.files specifically
      -- not disabling, I need this shit. alternatives?

      require('mini.surround').setup {
        custom_surroundings = {
          ['w'] = {
            output = function()
              local ft = vim.bo.filetype:lower()
              if ft == 'lua' then
                return { left = 'function() ', right = ' end' }
              elseif ft == 'go' then
                return { left = 'func (){', right = '}' }
              end
              return { left = '', right = '' }
            end,
          },
        },
      }
      local statusline = require 'mini.statusline' -- Simple and easy statusline.
      statusline.setup {
        content = {
          function()
            local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
            local git = MiniStatusline.section_git { trunc_width = 40 }
            local diff = MiniStatusline.section_diff { trunc_width = 75 }
            local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
            local lsp = MiniStatusline.section_lsp { trunc_width = 75 }
            local filename = MiniStatusline.section_filename { trunc_width = 140 }
            local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
            local location = MiniStatusline.section_location { trunc_width = 75 }
            local search = MiniStatusline.section_searchcount { trunc_width = 75 }

            return MiniStatusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              { hl = mode_hl, strings = { search, location } },
            }
          end,
          inactive = nil,
        },
        use_icons = vim.g.have_nerd_font,
      } -- set use_icons to true if you have a Nerd Font
      -- default behavior.
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() -- configure statusline sections by overriding their default behavior
        return '%2l:%-2v' -- Ex: here we set the section for cursor location to LINE:COLUMN
      end
    end, -- and there is more! Check out: https://github.com/echasnovski/mini.nvim
  },
}
