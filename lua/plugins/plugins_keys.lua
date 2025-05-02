local M = {
  plugins = {
    {
      --[which-key] - Show pending keybinds/motion completions
      'folke/which-key.nvim',
      event = 'VimEnter', -- Sets the loading event to 'VimEnter'
      opts = {
        delay = 0, -- delay between pressing a key and opening which-key (milliseconds) (independent of vim.opt.timeoutlen)
        icons = {
          mappings = vim.g.have_nerd_font, -- if nerd font use default map. which-key uses nf by default
          keys = vim.g.have_nerd_font and {} or require('plugins//storage').keys,
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
          -- is the toggleterm one causing an issue?
          --{ [[<C-\>]], group = 'ToggleTerm' },
        },
      },
    },
  },
}
return M.plugins
