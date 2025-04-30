local whichkey_keys_backup = {
  Up = '<Up> ',
  Down = '<Down> ',
  Left = '<Left> ',
  Right = '<Right> ',
  C = '<C-…> ',
  M = '<M-…> ',
  D = '<D-…> ',
  S = '<S-…> ',
  CR = '<CR> ',
  Esc = '<Esc> ',
  ScrollWheelDown = '<ScrollWheelDown> ',
  ScrollWheelUp = '<ScrollWheelUp> ',
  NL = '<NL> ',
  BS = '<BS> ',
  Space = '<Space> ',
  Tab = '<Tab> ',
  F1 = '<F1>',
  F2 = '<F2>',
  F3 = '<F3>',
  F4 = '<F4>',
  F5 = '<F5>',
  F6 = '<F6>',
  F7 = '<F7>',
  F8 = '<F8>',
  F9 = '<F9>',
  F10 = '<F10>',
  F11 = '<F11>',
  F12 = '<F12>',
}

return {
  {
    --[which-key] - Show pending keybinds/motion completions
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      delay = 0, -- delay between pressing a key and opening which-key (milliseconds) (independent of vim.opt.timeoutlen)
      icons = {
        mappings = vim.g.have_nerd_font, -- if nerd font use default map. which-key uses nf by default
        keys = vim.g.have_nerd_font and {} or whichkey_keys_backup,
      },
      spec = { -- Document existing key chords:
        { '<leader>c', group = '[A]pp' },
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { [[<C-\>]], group = 'ToggleTerm' },
      },
    },
  },
}
