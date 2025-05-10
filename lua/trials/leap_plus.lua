--          ╭─────────────────────────────────────────────────────────╮
--          │                  NOTE! Leap remaps s/S                  │
--          ╰─────────────────────────────────────────────────────────╯
--> hopefully this doesn't cause problems with surround/ai
---@param leapOn boolean enable leap.nvim
---@param flitOn boolean enable flit.nvim
---@param spookOn boolean enable leap-spooky. Takes priority over teleOn, can only have 1
---@param teleOn boolean enable telepath. disabled regardless if spookOn=true
local function initleap(leapOn, flitOn, spookOn, teleOn)
  local plugin = {

    { --Plugin to quickly jump anywhere in buffer/on screen
      'ggandor/leap.nvim',
      dependencies = {
        'tpope/vim-repeat',
      },
      enabled = leapOn,
      config = true, -- remove if having issues
    },
    { -- Leap extension, buffs f/F/t/T finds
      ' ggandor/flit.nvim',
      dependencies = {
        'ggandor/leap.nvim',
      },
      enabled = flitOn,
      config = true,
    },

    --  ┌                 ┐
    --  │ Pick one below! │
    --  └                 ┘
    -- telepath = alternative to leap-spooky, based on 'flash.nvim' remote text operations
    -- ──────────────────────────────────────────────────────────────────────
    { -- Leap extension. Seems like it adds leap to surround+other key combos. unsure of extent
      'ggandor/leap-spooky.nvim',
      enabled = spookOn,
      config = function()
        require('leap').set_default_mappings()
      end,
    },
    {
      'rasulomaroff/telepath.nvim',
      dependencies = 'ggandor/leap.nvim',
      -- there's no sence in using lazy loading since telepath won't load the main module
      -- until you actually use mappings
      lazy = false,
      enabled = (function() -- quick inline to prevent both spook and tele enabled
        if spookOn then
          return false
        else
          return teleOn
        end
      end)(),
      config = function()
        require('telepath').use_default_mappings()
      end,
    },
    -- ──────────────────────────────────────────────────────────────────────
  }

  -- will find out quick if this clashes with telepath config func
  --[[ 
  --this is what set_default_mappings does:
    vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
    vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')

    -- additional commands/keybinds:
    vim.keymap.set('n',        's', '<Plug>(leap-anywhere)')
    vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap)')

    see :h leap-custom-mappings for more
    if it's not all there, take a look at the github readme
  ]]
  return plugin
end

return initleap
