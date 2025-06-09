local Wf = {}
-- this was here to have multiple lists but I just put them in diff places
Wf.plugins = {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  { -- in-and-out: shift-enter to jump surrounding chars (tabout)
    'ysmb-wtsg/in-and-out.nvim',
    keys = {
      {
        '<S-CR>', --'<C-CR>'
        function()
          require('in-and-out').in_and_out()
        end,
        mode = 'i',
      },
    },
  },
  {
    'AckslD/nvim-trevJ.lua',
    opts = {},
  },
  {
    '2kabhishek/markit.nvim',
    config = true, --load_config 'tools.marks', -- never seen this before. setting to true for now
    event = { 'BufReadPre', 'BufNewFile' },
  },
  --Leap and extensions
}

return Wf.plugins
