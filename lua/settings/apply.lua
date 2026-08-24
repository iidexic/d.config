---@class Cfg
local Cfg = {
  map = require 'settings.mapping',
  vimconfig = require 'settings.vimconfig',
  vimutil = require 'settings.vim_util',
  autocommands = require 'settings.autocommands',
  commands = require 'settings.commands',
  addfunctionality = require 'settings.vim_functionality',
}

---@param name string name of theme to apply
function Cfg.theme(name)
  Cfg.themeName = name
end

function Cfg.prelazy()
  Cfg.vimconfig.first()
  --  Cfg.map.assign()
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

  -- TODO: update to new mappings file
  Cfg.map.assign()
  Cfg.vimutil.map_vim_utils()
  Cfg.map.plugins()
  Cfg.autocommands.post_autocmd()
  Cfg.commands.make_commands()
  -- Cfg.addfunctionality.autocommands() -- was for tab buffer switch
end
return Cfg
