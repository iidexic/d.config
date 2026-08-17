local M = {}
-- Mainly where plugins go that I want to tweak internally
local fp = {
  iconpicker = 'c:/dev/luaprojects/icon-picker.nvim',
  miss = 'c:/dev/luaprojects/miss.nvim',
  dur = 'c:/dev/luaprojects/dur.nvom',
  material = 'c:/dev/luaprojects/material.nvim',
  helpme = 'c:/dev/luaprojects/helpme',
  scratch = 'c:/dev/luaprojects/scratch.nvim',
}
local function ifFile(path)
  if fp[path] then
    path = fp[path] .. '/init.lua'
  end
  local f = function()
    local file = io.open(path, 'r')
    if file ~= nil then
      io.close(file)
      return true
    else
      return false
    end
  end
  return f
end

M.plugins = {
  -- { -- icon-picker: telescope picker for Nerd Fonts icons
  --   'ziontee113/icon-picker.nvim',
  --   dir = fp.iconpicker,
  --   dev = ifFile 'iconpicker',
  --   config = function()
  --     local ip = require 'icon-picker'
  --     ip.setup { disable_legacy_commands = true }
  --
  --     local opts = { noremap = true, silent = true }
  --
  --     vim.keymap.set('n', '<Leader>ui', '<cmd>IconPickerNormal<cr>', opts)
  --     --vim.keymap.set('n', '<Leader><Leader>y', '<cmd>IconPickerYank<cr>', opts) --> Yank the selected icon into register
  --     vim.keymap.set('i', '<C-i>', '<cmd>IconPickerInsert<cr>', opts) --insert mode
  --   end,
  -- },
  {
    'iidexic/miss.nvim',
    -- test github repo ver
    dir = fp.miss,
    dev = ifFile 'miss',
    opts = { key_miss = '<leader>um' },
  },
  -- {
  --   'iidexic/dur.nvom',
  --   dir = fp.dur,
  --   dev = ifFile 'dur',
  --   keys = function(self, keys)
  --     local map = {}
  --     return map
  --   end,
  --   opts = {},
  -- },
  {
    'iidexic/d.nvim',
    dir = 'c:/dev/luaprojects/d.nvim/',
    dev = true,
    opts = {
      plugins = {
        'neo-tree',
        'neogit',
        'which-key',
        'lspsaga',
        'trouble',
        'gitsigns',
        'dap',
        'indent-blankline',
        'nvim-cmp',
        'fidget',
        'mini',
        'telescope',
        'nvim-web-devicons',
      },
    },
  },
  -- { 'helpme', dir = 'c:/dev/luaprojects/helpme/', dev = true },
  { -- Scratch: Create general/language-specific scratch buffers
    'iidexic/scratch.nvim',
    dir = fp.scratch,
    dev = ifFile 'scratch',
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
