return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
    -- NOTE: nvim-cmp integration was removed. blink.cmp is the active completion
    -- engine and has built-in autopair behavior via `keymap` config.
  },
  -- { -- in-and-out: shift-enter to jump surrounding chars (tabout)
  --   'ysmb-wtsg/in-and-out.nvim',
  --   keys = {
  --     {
  --       '<S-CR>', --'<C-CR>'
  --       function()
  --         require('in-and-out').in_and_out()
  --       end,
  --       mode = 'i',
  --     },
  --   },
  -- },
  {
    '2kabhishek/markit.nvim',
    config = true, --load_config 'tools.marks', -- never seen this before. setting to true for now
    cond = false, -- Failing
    event = { 'BufReadPre', 'BufNewFile' },
  },
  --Leap and extensions
}
