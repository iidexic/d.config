local M = {
  plugins = {
    {
      'akinsho/bufferline.nvim',
      version = '*',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'cbochs/grapple.nvim',
        -- I think grapple needs to be installed before bufferline
        -- check grapple config
      },
      config = function()
        local bufferline = require 'bufferline'
        local opts = {

          options = {
            --mode = 'buffers', --| 'tabs'
            --style_preset = bufferline.style_preset.default, -- or style_preset.default
            --separator_style = 'slope',

            indicator = {
              icon = '󰇝', -- this should be omitted if indicator style is not 'icon'
              style = 'icon', --| 'underline' | 'none',
            },
            groups = {
              items = {
                {
                  name = '󰛢',
                  priority = 1,
                  highlight = { sp = '#302f2f' },
                  matcher = function(buf)
                    return require('grapple').exists { buffer = buf.id }
                  end,
                },
              },
            },
            name_formatter = function(buf)
              local grapple = require 'grapple'
              local fname = ''
              if buf.bufnr and grapple.exists { buffer = buf.bufnr } then
                local gnum = grapple.name_or_index { buffer = buf.bufnr }
                fname = buf.name .. ' 󰛢 ' .. require('utilfunctions').grappleKey(gnum)
              else
                fname = buf.name
              end
              return fname
              -- buf contents (buffer mode): name (file basename), path (full filepath), bufnr,
              -- buf contents (tab mode): buffers (table(int) of bufnrs in tab),
              --    tabnr ("handle" of the tab, convert to ordinal number: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
            end,

            max_name_length = 26,
            tab_size = 16,
            diagnostics = 'nvim_lsp', -- false | "coc", --false is default

            offsets = {
              {
                filetype = 'neo-tree',
                text = 'Neo-Tree',
                text_align = 'center',
                separator = true,
              },
            },
          },
        }

        --[[ groups = {
    items = {
      {
        name = 'tagged',
        priority = 1,
        highlight = { underline = true, sp = 'gold' },
        matcher = function(buf)
          return buf.bufnr and require('grapple').exists { buffer = buf.bufnr }
        end,
      },
    },
    other = {
      {
        name = 'not_tagged',
        priority = 2,
        matcher = function(buf)
          return not (buf.bufnr and require('grapple').exists { buffer = buf.bufnr })
        end,
      },
    },
  } ]]
        bufferline.setup(opts)
      end,
    },
  },
}

return M
