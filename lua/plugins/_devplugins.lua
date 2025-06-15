local M = {}

M.plugins = {
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
