--- setting up as standard plugin file
--- Check standard Leap Plus file for notes
local M = {}
M.plugins = {

  { --Plugin to quickly jump anywhere in buffer/on screen
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat',
    },
    cond = true,
    config = true,
  },
  { -- Leap extension, buffs f/F/t/T finds
    'ggandor/flit.nvim',
    dependencies = {
      'ggandor/leap.nvim',
    },
    cond = true,
    config = true,
  },

  --  ┌                 ┐
  --  │ Pick one below! │
  --  └                 ┘
  -- telepath = alternative to leap-spooky, based on 'flash.nvim' remote text operations
  -- ──────────────────────────────────────────────────────────────────────
  { -- Leap extension. Seems like it adds leap to surround+other key combos. unsure of extent
    'ggandor/leap-spooky.nvim',
    cond = true,
    config = true,
  },
  {
    'rasulomaroff/telepath.nvim',
    dependencies = 'ggandor/leap.nvim',
    lazy = false,
    cond = false,
    config = function()
      require('telepath').set_default_mappings()
    end,
  },
}
M.setup = function() end
return M.plugins
