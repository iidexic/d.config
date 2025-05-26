--# utility functions
local len = function(t)
  local c = 0
  for _ in pairs(t) do
    c = c + 1
  end
  return c
end
---@param plugin table single-plugin, not nested
local function dirtycheckplug(plugin)
  return type(plugin[1]) == 'string' and string.find(plugin[1], '../..')
end

---@class P plugin list builder
---@field allplugins table                # table of all plugins to load
---@field add function(table)             # add a table of plugins to P.allplugins
---@field loadfiles function(table)       # given table of module/file names, load all plugins in return table of each file
---@field getconditionals function(table) # load conditional plugins, enabling only those named in enableplugins table
---@field populate function(table)        # pulls plugin data from module/table directly
---@field setups function[]         populated with custom setup functions as plugins are pulled in
local P = { allplugins = {}, pnames = {}, setups = {} }

--- nplugs: len(allplugins)@lazycall, ins: P.add inserts to allplugins
--- bad = dirtycheck false, reqs: count of files required
--- ers = empty req returns, mods: count loadmodule calls, noms = mod call w/empty module
P.n = { nplugs = 0, xnplugs = 0, ins = 0, bad = 0, reqs = 0, ers = 0, mods = 0, noms = 0, setups = 0, sdone = 0 }

function P.add(plugins)
  for _, plug in ipairs(plugins) do
    if dirtycheckplug(plug) then
      table.insert(P.allplugins, plug)
      P.n.ins = P.n.ins + 1 --++
    else
      P.n.bad = P.n.bad + 1 --++
    end
  end
end

function P.loadfiles(filetable)
  ---@ directly load files in filetbl to plugins table
  --!TODO: add ability to pull from mod.plugins, add ability to run mod.setup()
  for _, f in ipairs(filetable) do
    local mod = require(f)
    P.n.reqs = P.n.reqs + 1 --++
    if mod then
      if mod.plugins then
        -- add
        P.add(mod.plugins)
      elseif type(mod[1]) == table then
        P.add(mod)
      end
      if mod.setup and type(mod.setup) == 'function' then
        P.n.setups = P.n.setups + 1 --++
        table.insert(P.setups, mod.setup)
      end
    end
    if mod and type(mod[1]) == 'table' then
      P.add(mod)

      -- Just in case, make an attempt
      -- Probably just delete this
    elseif mod and type(mod[1]) == 'string' then
      P.add { mod }
    else
      P.n.ers = P.n.ers + 1 --++
    end
  end
end

---load plugins from module directly (or just a table if that was the require return)
---@param mod table<any> # get plugin details from a module
function P.loadmodule(mod)
  if mod then
    -- if module has a 'plugins' element
    if mod.plugins then
      P.n.mods = P.n.mods + 1 --++
      P.add(mod.plugins)
    -- if module directly returns a plugin table
    elseif mod[1] and mod[1][1] and type(mod[1][1]) == 'string' then
      P.add(mod)
      P.n.mods = P.n.mods + 1 --++
    else
      P.n.noms = P.n.noms + 1 --++
    end
    if mod.setup and type(mod.setup) == 'function' then
      P.n.setups = P.n.setups + 1 --++
      table.insert(P.setups, mod.setup)
    end
  else
    P.n.noms = P.n.noms + 1 --++
  end
end

function P.runsetup()
  for _, sfunc in pairs(P.setups) do
    if type(sfunc) == 'function' then
      P.n.sdone = P.n.sdone + 1 --++
      sfunc()
    end
  end
end

function P.N()
  P.n.nplugs = #P.allplugins --++
  for _ in pairs(P.allplugins) do
    P.n.xnplugs = P.n.xnplugs + 1 --++
  end
  P.n.xnplugs = P.n.xnplugs - P.n.nplugs

  local ndetail = {
    nplugs = 'Plugins passed to lazy: ',
    xnplugs = 'Extra things in plugin table: ',
    ins = 'Plugins inserted by add(): ',
    bad = 'Failed dirty checks in add(): ',
    reqs = 'Require(file) calls in loadfiles(): ',
    ers = 'Empty requires in loadfiles(): ',
    mods = 'Modules passed to loadmodule(): ',
    noms = 'Calls with no/empty loadmodule(): ',
    setups = 'Setup functions added: ',
    sdone = 'Setup functions executed: ',
  }
  local prtstr = '===============| PluginLoader Stats: |==============\n'
  for k, v in pairs(P.n) do
    prtstr = prtstr .. ndetail[k] .. v .. '\n'
  end
  vim.api.nvim_create_user_command('DcfgStat', function()
    vim.print(prtstr)
  end, {})
end

---@param enableplugins table list of plugin in conditional table to enable
function P.getconditionals(enableplugins)
  local cond = require 'conditional.loadconditional'
  cond.set(enableplugins)
  local cplugs = cond.getplugins()
  P.add(cplugs)
end

return P
