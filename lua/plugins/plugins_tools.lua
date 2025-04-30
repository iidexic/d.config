return {
  { 'tpope/vim-sleuth' }, -- Detect tabstop/shiftwidth automatically
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = [[<C-\>]],
      persist_size = false,
    },
    config = true,
    lazy = true,
    keys = { { '<leader>at', '<cmd>ToggleTerm<cr>', desc = '[A]pp: [t]erminal' } },
  },
  {
    'willothy/flatten.nvim',
    config = true, -- or pass configuration with opts = {  }
    lazy = false,
    priority = 1001, -- Ensure that it runs first to minimize delay when opening file from terminal
  },
  {
    'LintaoAmons/scratch.nvim',
    event = 'VeryLazy',
  },
}
