return {
  { 'tpope/vim-sleuth' }, -- Detect tabstop/shiftwidth automatically
  { -- terminal
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      open_mapping = [[<C-\>]],
      persist_size = false,
      shell = 'nu',
      size = function(term)
        if term.direction == 'horizontal' then
          return 14
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.3
        end
      end,
    },
    config = true,
    lazy = false,
    -- trying to disable this to see if it makes the above mapping work from the start
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
  {
    'OXY2DEV/markview.nvim',
    lazy = false,
    opts = { preview = { icon_provider = 'devicons' } },
    -- For blink.cmp's completion
    -- source
    -- dependencies = {
    --     "saghen/blink.cmp"
    -- },
  },
  {
    'uga-rosa/ccc.nvim',
    opts = {},
  },
  {
    'famiu/bufdelete.nvim',
    keys = {
      {
        '<leader><BS>',
        function()
          require('bufdelete').bufwipeout(0)
        end,
        desc = 'Bufdelete',
      },
      {
        '<C-Backspace>',
        function()
          require('bufdelete').bufdelete(0, true)
        end,
        desc = 'Bufdelete Forcibly',
      },
    },
  },
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
}
