---@class Cond conditional plugin loader
---@field Cond.plugins table all plugins that can be conditionally enabled/disabled
---@field any boolean flipped to true if at least 1 plugin is enabled
---
---@field set function used to input the list of enabled plugins list
---@field enabled table table of strings;
local Cond = {
  plugins = {
    {
      'CWood-sdf/pineapple',
      dependencies = require 'theme.pineapple',
      opts = {
        installedRegistry = 'theme.pineapple',
        colorschemeFile = 'after/plugin/themedata.lua',
      },
      enabled = false,
      cmd = 'Pineapple',
      lazy = true,
      keys = { { '<leader>ap', '<cmd>Pineapple<cr>', desc = '[A]pp: [P]ineapple' } },
    },
    --{ 'lmantw/themify.nvim', lazy = false, priority = 999, config = {}, enabled = false },
    {
      'willothy/wezterm.nvim',
      name = 'wezterm.nvim',
      config = true,
      enabled = false,
      opts = {
        create_commands = true,
      },
      lazy = true,
    },
  },
  any = false,
}

function Cond.set(enableplugins)
  Cond.enabled = enableplugins
  Cond.is_set = true
end

function Cond.check(plugname)
  if Cond.is_set and Cond.enabled[plugname] then
    Cond.any = true
    return true
  else
    return false
  end
end

function Cond.getplugins()
  return Cond.plugins
end

return Cond
