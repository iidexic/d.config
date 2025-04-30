--== The current-state setup for plugin loading ==--
L = {
  LazyConfig = function()
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
  end,
}
return L
