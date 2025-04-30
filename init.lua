--[[
Config Todo
  * clean up * ideally ensure that I can get full trace on errors

Other plugins/plugin types to try:
----------------------------------------------
--- autopairs (kickstart/plugins/autopairs.lua)
----- automatically adds close for bracket open/quote open.
----- mini.pairs does this when first typed, but autopairs here seems to do it when press enter? not sure
--- Trailblazer (plugins/trailblazer.lua)
----- Marks - alternative to Grapple. Config is already ready to go
--- Buffon.nvim (plugins/buffon.lua)
----- Alt to marks for buffer nav. Don't know much about it
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

--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-----[load plugins]-----
local kickstart = require 'kickstart_lazy' -- primary list of plugins; original kickstart list
local mini = require 'plugins.mini'
local dplugs = require 'dplugins'
local telescopes = require 'plugins.telescopes'
local thememaker = require 'theme.themes'
local ksindent = require 'kickstart.plugins.indent_line'
local themes = thememaker.getlist()
-- Telescope may need to be further back? Not sure if it matters
local plugins = dplugs.imergetables { kickstart, dplugs.dplugins, ksindent, mini, telescopes, themes }

--[[
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

require('lazy').setup(plugins, {
  ui = { -- If using a Nerd Font: set icons to an empty table , otherwise define a unicode icons table:
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
--#post-lazy load
--vim.cmd.colorscheme(theme_name)
configure.postlazy()

--!NOTE: DO NOT DELETE BELOW
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
