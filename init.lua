--[[
Config Todo
----------------------------------------------
  * need git integration
  * separate vim.opt configuration here into own file.
  * clean up
  * conditional plugins
  * plugin list builder
  * ideally ensure that I can get full trace on errors
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
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local kickstart = require 'kickstart_lazy' -- primary list of plugins; original kickstart list
local mini = require 'plugins.mini'
local dplugs = require 'dplugins'
local telescopes = require 'plugins.telescopes'
local thememaker = require 'theme.themes'
local ksindent = require 'kickstart.plugins.indent_line'
local themes = thememaker.getlist()

local plugins = dplugs.imergetables { telescopes, kickstart, ksindent, mini, dplugs.dplugins, themes }
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
