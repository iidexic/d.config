---@class Cfg
local Cfg = {
  map = require 'settings.mapping',
  vimconfig = require 'settings.vimconfig',
}

---@param name string name of theme to apply
function Cfg.theme(name)
  Cfg.themeName = name
end

function Cfg.prelazy()
  Cfg.vimconfig.first()
  Cfg.map.assign()
  --[[ if opts then
    if opts.keys then
      for i, bind in opts.keys do
        -- bind that shit
      end end end
--]]
end

---@param opts table | nil list of optional settings, { optionname = "val or truthy"}
function Cfg.postlazy(opts)
  Cfg.vimconfig.last(opts)
  if Cfg.themeName then
    vim.cmd.colorscheme(Cfg.themeName)
  end
  -- if opts then
end
return Cfg
