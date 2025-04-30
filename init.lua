--[[
Config Todo
  * clean up * ideally ensure that I can get full trace on errors

--]]
--original config apply section is in old.fake.lua

local configure = require 'settings.apply'
configure.prelazy()
configure.theme 'evergarden' --Nordic

vim.api.nvim_create_autocmd('TextYankPost', { -- Try it with `yap` in normal mode
  desc = 'Highlight when yanking (copying) text', --See`:help vim.highlight.on_yank()`
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--# This Lazy
--require('currentstate_init').LazyConfig()

--# Or This Lazy
require('dlazyinit').LazyPluginSetup()
--# Post-Lazy load
configure.postlazy()

--[[
Other plugins/plugin types to try:
----------------------------------------------
--- autopairs (kickstart/plugins/autopairs.lua)
----- automatically adds close for bracket open/quote open.
----- mini.pairs does this when first typed, but autopairs here seems to do it when press enter? not sure
--- Trailblazer (plugins/trailblazer.lua)
----- Marks - alternative to Grapple. Config is already ready to go
--- Buffon.nvim (plugins/buffon.lua)
----- Alt to marks for buffer nav. Don't know much about it

===|->| List Currently Installed Plugins |<-|===

-< Telescope.nvim
--> extensions:{Whaler.nvim, 
-< Grapple.nvim
-< 
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
-<
--]]

--!NOTE: DO NOT DELETE BELOW
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
