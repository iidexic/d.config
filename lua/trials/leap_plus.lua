--          ╭─────────────────────────────────────────────────────────╮
--          │                  NOTE! Leap remaps s/S                  │
--          ╰─────────────────────────────────────────────────────────╯

--> hopefully this doesn't cause problems with surround/ai
--> it does. I think it overwrites both
--> Time to fix it :)
---setup leap and additiobnal plugins
---@param leapOn boolean enable leap.nvim
---@param flitOn boolean enable flit.nvim
---@param spookOn boolean enable leap-spooky. Takes priority over teleOn, can only have 1
---@param teleOn boolean enable telepath. disabled regardless if spookOn=true
local function initleap(leapOn, flitOn, spookOn, teleOn)
  local M = {}
  M.plugins = {

    { --Plugin to quickly jump anywhere in buffer/on screen
      'ggandor/leap.nvim',
      dependencies = {
        'tpope/vim-repeat',
      },
      cond = leapOn,
      config = true,
    },
    { -- Leap extension, buffs f/F/t/T finds
      'ggandor/flit.nvim',
      dependencies = {
        'ggandor/leap.nvim',
      },
      cond = flitOn,
      config = true,
    },

    --  ┌                 ┐
    --  │ Pick one below! │
    --  └                 ┘
    -- telepath = alternative to leap-spooky, based on 'flash.nvim' remote text operations
    -- ──────────────────────────────────────────────────────────────────────
    { -- Leap extension. Seems like it adds leap to surround+other key combos. unsure of extent
      'ggandor/leap-spooky.nvim',
      cond = spookOn,
      config = true,
    },
    {
      'rasulomaroff/telepath.nvim',
      dependencies = 'ggandor/leap.nvim',
      -- there's no sense in using lazy loading since telepath won't load the main module
      -- until you actually use mappings
      lazy = false,
      cond = (function() -- quick inline to prevent both spook and tele enabled
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

  -- ┌───────────────────────────────────────────── leap key aliases: ────┐
  --[[
    -> <Plug>(leap)
    -> <Plug>(leap-from-window
    -> <Plug>(leap-anywhere)
    -> <Plug>(leap-forward)
    -> <Plug>(leap-forward-to)
    -> <Plug>(leap-forward-till)
    -> <Plug>(leap-backward)
    -> <Plug>(leap-backward-to)
    -> <Plug>(leap-backward-till)
 --]]
  -- └────────────────────────────────────────────────────────────────────┘
  M.setup = function() end

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
  return M
end

return initleap
