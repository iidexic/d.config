---@param plugin table single-plugin, not nested
local function dirtycheckplug(plugin)
  return type(plugin[1]) == 'string' and string.find(plugin[1], '../..')
end
local P = {}
P.plugins = {}
P.pnames = {}
function P.join(tbl1, tbl2)
  for _, val in ipairs(tbl2) do
    table.insert(tbl1, val)
  end
  return tbl1
end

function P.adds(plugins)
  for _, plug in ipairs(plugins) do
    if dirtycheckplug(plug) then
      table.insert(P.plugins, plug)
    end
  end
end
---@param plugin table single-plugin, not nested
function P.add(plugin)
  if dirtycheckplug(plugin) then
    table.insert(P.plugins, plugin)
  end
end

---directly load files in filetbl to plugins table
---@param filetbl table table with files to require and merge
function P.loadfiles(filetbl)
  for _, f in ipairs(filetbl) do
    local mod = require(f)
    if mod and type(mod[1]) == 'table' then
      P.adds(mod)
    -- Just in case, make an attempt
    elseif mod and type(mod[1]) == 'string' then
      P.add(mod)
    end
  end
end
--[[
--#How to do conditional plugs
Currently looking at 2 methods of loading conditionals:
1. send list of plugin names, P.loadconditionals adds them to list
2. add enabled = cond[i] or something to each conditional plugin

Option 2 seems better because they will not be marked for cleanup by Lazy every single time
need to figure out how to do that

--]]
return P
