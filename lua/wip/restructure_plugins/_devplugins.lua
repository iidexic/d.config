local M = {}

M.plugins = {
  { -- icon-picker: telescope picker for Nerd Fonts icons
    'ziontee113/icon-picker.nvim',
    dir = 'c:/dev/luaprojects/icon-picker.nvim/',
    dev = true,
    config = function()
      local ip = require 'icon-picker'
      ip.setup { disable_legacy_commands = true }

      local opts = { noremap = true, silent = true }

      vim.keymap.set('n', '<Leader>ui', '<cmd>IconPickerNormal<cr>', opts)
      --vim.keymap.set('n', '<Leader><Leader>y', '<cmd>IconPickerYank<cr>', opts) --> Yank the selected icon into register
      vim.keymap.set('i', '<C-i>', '<cmd>IconPickerInsert<cr>', opts) --insert mode
    end,
  },
  {
    'iidexic/miss.nvim',
    -- test github repo ver
    dir = 'c:/dev/luaprojects/miss.nvim',
    dev = true,
    opts = { key_miss = '<leader>um' },
  },
  {
    'iidexic/dur.nvom',
    dir = 'c:/dev/luaprojects/dur.nvom',
    dev = true,
    keys = function(self, keys)
      local map = {}
      return map
    end,
    opts = {},
  },
  { 'iidexic/material.nvim', dir = 'c:/dev/luaprojects/material.nvim/', dev = true, opts = {} },
  { 'helpme', dir = 'c:/dev/luaprojects/helpme/', dev = true },
  { -- Scratch: Create general/language-specific scratch buffers
    'iidexic/scratch.nvim',
    dir = 'c:/dev/luaprojects/scratch.nvim/',
    dev = true,
    dependencies = { 'nvim-telescope/telescope.nvim' },
    event = 'VeryLazy',
    keys = { { '<leader>us', '<cmd>Scratch<CR>', 'New Scratch Buffer' } },
    opts = {
      file_picker = 'telescope',
      filetypes = { 'lua', 'go', 'zig', 'python' },
      filetype_details = {
        go = {
          requireDir = true, -- true if each scratch file requires a new directory
          filename = 'main', -- the filename of the scratch file in the new directory
          content = { 'package main', '', 'func main() {', '  ', '}' },
          cursor = {
            location = { 4, 2 },
            insert_mode = true,
          },
        },
      },
      --filetype_details = {go = {...}} --* iffff go is acting weird, copy the section from helpfile to here
    },
  },
}

return M.plugins
