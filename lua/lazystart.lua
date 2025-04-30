local plugload = require 'pluginloader'
--# Main Plugins
local files = {
  'plugins.buffon',
  'plugins.codeplugins',
  'plugins.mini',
  'plugins.plugins_auto',
  'plugins.plugins_debug_kickstart',
  'plugins.plugins_git',
  'plugins.plugins_keys',
  'plugins.plugins_lsp',
  'plugins.plugins_tools',
  'plugins.plugins_visual',
  'plugins.plugins_workflow',
  'plugins.telescopes',
  'plugins.trailblazer',
  'plugins.treesitters',
}
plugload.loadfiles(files)

--# Conditional Plugins
---Dont need any right now
plugload.getconditionals()

--# Lazy definitions
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

--# Lazy setup
require('lazy').setup(plugload.allplugins, {
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
