local M = {
  plugins = { {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
  } },
  -- buffer editor for bufferline. No idea what this means
  {
    'exit91/bufferline-editor.nvim',
    dependencies = 'akinsho/bufferline.nvim',
  },
}
function M.setup()
  local bufferline = require 'bufferline'
  --local grapple = require 'grapple'
  local opts = {
    options = { --mode = 'buffers', --| 'tabs'
      --style_preset = bufferline.style_preset.default, -- or style_preset.minimal
      style = 'underline',
      --

      --grapple.options: buffer? integer , path? string ,name? string, index? integer ,cursor? integer[], scope? string, scope_id? string, command? fun(path: string)
      -- name_formatter can be used to change the buffer's label in the bufferline.
      -- some names can/will break the bufferline, use at your discretion knowing it has limitations
      -- buf contains:
      -- for buffer mode: base [name](str) of file, full [path](str), [bufnr](int),
      -- for tab mode: numbers of the [buffers](tbl{int}), tab handle id [tabnr](int) - can convert to ordinal with `vim.api.nvim_tabpage_get_number(buf.tabnr)`
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

      max_name_length = 22,
      --max_prefix_length = 15, -- prefix used when buffer is de-duplicated
      --truncate_names = true, -- whether or not tab names should be truncated
      tab_size = 16,
      diagnostics = 'nvim_lsp', -- false | "coc", --false is default
      -- diagnostics_update_in_insert = false, -- only applies to ----coc
      --diagnostics_update_on_event = true, -- use nvim's diagnostic handler
      --[[
            -- diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                return "("..count..")"
            end,
            -- NOTE: this will be called a lot so don't do any heavy processing here
            custom_filter = function(buf_number, buf_numbers)
                -- filter out filetypes you don't want to see
                if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
                    return true
                end
                -- filter out by buffer name
                if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
                    return true
                end
                -- filter out based on arbitrary rules
                -- e.g. filter out vim wiki buffer from tabline in your work repo
                if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
                    return true
                end
                -- filter out by it's index number in list (don't show first buffer)
                if buf_numbers[1] ~= buf_number then
                    return true
                end
            end,
    --]]
      offsets = {
        {
          filetype = 'neo-tree',
          text = 'Neo-Tree',
          text_align = 'center',
          separator = true,
        },
        {
          filetype = 'neo-tree',
          text = 'Neo-Tree',
          text_align = 'center',
          separator = true,
        },
      },
    },
  }
  bufferline.setup(opts)
end

return M

--[[
-- ── Other Bufferline Options ────────────────────────────────────────
      --numbers->'none'|'ordinal'|'buffer_id'|'both'|function({ordinal,id,lower,raise}):string (i think none is default)
      --close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
      --right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
      --left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
      --middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
      --indicator = { icon = '▎', -- this should be omitted if indicator style is not 'icon'
      --style = 'icon' | 'underline' | 'none', },

      --buffer_close_icon = '󰅖',
      --modified_icon = '● ',
      --close_icon = ' ',
      --left_trunc_marker = ' ',
      --right_trunc_marker = ' ',

      --[[
      offsets = { { 
        filetype = 'NvimTree',
        text = "File Explorer" | function ,
        text_align = 'left'| "center" | "right"
        separator = true,
        },
      },
      --]]
--[[ get_element_icon = function(element) element consists of {filetype: string, path: string, extension: string, directory: string}
              This can be used to change how bufferline fetches the icon for an element e.g. a buffer or a tab. 
              e.g. `local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false }) return icon, hl`
              or `local custom_map = {my_thing_ft: {icon = "my_thing_icon", hl}} return custom_map[element.filetype] end,` ]]
--show_buffer_icons = true | false, -- disable filetype icons for buffers
--show_buffer_close_icons = true | false,
--show_close_icon = true | false,
--show_tab_indicators = true | false,
--show_duplicate_prefix = true | false, -- whether to show duplicate buffer prefix
--duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
--persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
--move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
-- can also be a table containing 2 custom separators
-- [focused and unfocused]. eg: { '|', '|' }
--separator_style = 'slant' | 'slope' | 'thick' | 'thin' | { 'any', 'any' },
--enforce_regular_tabs = false | true,
--always_show_bufferline = true | false,
--auto_toggle_bufferline = true | false,
--hover = { enabled = true, delay = 200, reveal = { 'close' }, },
--[[
      sort_by = 'insert_after_current' | 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
        -- add custom logic
        local modified_a = vim.fn.getftime(buffer_a.path)
        local modified_b = vim.fn.getftime(buffer_b.path)
        return modified_a > modified_b
      end,
      --]]
--pick = { alphabet = 'abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890', },
--]]
