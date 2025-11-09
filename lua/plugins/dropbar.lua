--[[
DROPBAR NOTE: Basically ready to go. Pulling to try and cut plugin quantity. 
      - GOING BACK TO LSPSAGA. Fixed the issue I had in the first place (colors) with an autocommand
      - keymap setting has been relocated back here, in config
--]]
return {
  {
    'Bekaboo/dropbar.nvim',
    -- optional, but required for fuzzy finder support
    enabled = false,
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      'folke/which-key.nvim', -- to assign mappings in config func
      build = 'make',
    },
    config = function()
      local dropbar_api = require 'dropbar.api'
      local mappings = {
        { '<Leader>;', dropbar_api.pick, desc = 'Pick symbols in winbar' },
        { '[;', dropbar_api.goto_context_start, desc = 'Go to start of current context' },
        { '];', dropbar_api.select_next_context, desc = 'Select next context' },
      }
      local wk = require 'which-key'
      wk.add(mappings)
    end,
  },
}
