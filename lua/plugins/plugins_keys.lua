local M = {}
--[[
local function wksg()
  require('which-key').show { global = true }
end
local function showallWK()
  local wk = require 'which-key'
  local wks = wk.show
  local g = { global = true }
  local set = {
    { 'n', 'a', wksg },
    { 'n', 'i', wksg },
  }
en]]
--keys = { { '<leader>?', function() require('which-key').show { global = false } end, desc = 'Buffer Local Keymaps (which-key)', }, },
M.plugins = {
  {
    --[which-key] - Show pending keybinds/motion completions
    'folke/which-key.nvim',
    event = 'VeryLazy', --'VimEnter', -- Sets loading event
    keys = {
      {
        mode = { 'n', 'v' },
        '<leader>??',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Which-key',
      },
      {
        mode = { 'n', 'v' },
        '<leader>?g',
        function()
          require('which-key').show { global = true, loop = true }
        end,
        desc = 'Which-key Global persistent',
      },
      --[[
      {
        mode = {'n','v'},
          '<leader>?ay',
          showallWK
      },
      {
        mode = {'n,v'},
        '<leader>?an',

      }
--]]
    },
    desc = 'Buffer Local Keymaps (which-key)',
    opts = {
      delay = 10, -- delay between pressing a key and opening which-key (milliseconds) (independent of vim.opt.timeoutlen)

      keys = { scroll_down = '<c-n>', scroll_up = '<c-p>' },

      icons = {
        mappings = vim.g.have_nerd_font, -- if nerd font use default map. which-key uses nf by default
        keys = vim.g.have_nerd_font and {} or require('plugins//storage').keys,
      },
      spec = { -- Document existing key chords:
        { '<leader>?', group = '[which-key]' },
        --{ '<leader>a', group = '[A]pp' },
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>cs', group = '[C]ode [S]ymbols', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>g', group = '[G]it', mode = { 'n', 'v' } },
        { '<leader>l', group = '[L]anguage functions', mode = { 'n', 'v' } },
        { '<leader>p', group = '[P]ersist' },
        { '<leader>P', group = '[P]ersist (stop using pls)' },
        { '<leader>u', group = '[U]tility' },
        { '<leader>x', group = 'Trouble' },
      },
    },
  },
}

return M.plugins
