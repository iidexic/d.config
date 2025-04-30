---@param plugin table single-plugin, not nested
local function dirtycheckplug(plugin)
  return type(plugin[1]) == 'string' and string.find(plugin[1], '../..')
end

---@class P plugin list builder
---@field allplugins table of multiple plugins
---@field add function add a table of plugins to P.allplugins
---@field loadfiles function given table of module/file names, load all plugins in return table of each file
---@field getconditionals function load conditional plugins, enabling only those named in enableplugins table
local P = { allplugins = {}, pnames = {} }
function P.add(plugins)
  for _, plug in ipairs(plugins) do
    if dirtycheckplug(plug) then
      table.insert(P.allplugins, plug)
    end
  end
end

function P.loadfiles(filetable)
  ---@ directly load files in filetbl to plugins table
  for _, f in ipairs(filetable) do
    local mod = require(f)
    if mod and type(mod[1]) == 'table' then
      P.add(mod)

      -- Just in case, make an attempt
      -- Probably just delete this
    elseif mod and type(mod[1]) == 'string' then
      P.add { mod }
    end
  end
end

---@param enableplugins table list of plugin in conditional table to enable
function P.getconditionals(enableplugins)
  local cond = require 'conditional.loadconditional'
  cond.set(enableplugins)
  local cplugs = cond.getplugins()
  P.add(cplugs)
end

return P
