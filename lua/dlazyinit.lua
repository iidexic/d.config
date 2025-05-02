local D = {
  LazyPluginSetup = function()
    local plugload = require 'pluginloader'
    --# Main Plugins
    local files = {
      'plugins.lang-support',
      'plugins.mini',
      'plugins.neo-tree',
      'plugins.plugins_auto',
      'plugins.plugins_debug',
      'plugins.plugins_git',
      'plugins.plugins_keys',
      'plugins.plugins_lsp',
      'plugins.plugins_tools',
      'plugins.plugins_visual',
      'plugins.plugins_workflow',
      'plugins.telescopes',
      'plugins.treesitters',
      'plugins.trouble',
      -- 'plugins.buffon', -- clashes with way too many keys. Setting up grapple like this tho
      --'plugins.trailblazer', -- moving to 'trials' folder
    }
    plugload.loadfiles(files)

    --# Conditional Plugins
    ---Dont need any right now
    plugload.getconditionals()

    --# Themes
    plugload.add(require('theme.themes').getlist())

    ------------------------------------------------------------------------------
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
  end,
}

return D
