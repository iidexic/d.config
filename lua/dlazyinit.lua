local D = {
  LazyPluginSetup = function()
    local plugload = require 'pluginloader'
    --# Main Plugins
    local files = {
      'plugins.plugins_debug',
      'plugins.lang-support',
      'plugins.plugins_lsp',
      'plugins.mini',
      'plugins.layout',
      'plugins.persistence',
      'plugins.filemanager',
      'plugins.plugins_auto',
      'plugins.plugins_debug',
      'plugins.plugins_git',
      'plugins.plugins_keys',
      'plugins.plugins_tools',
      'plugins.plugins_visual',
      'plugins.plugins_workflow',
      'plugins.bufferline',
      'plugins.telescopes',
      'plugins.treesitters',
      'plugins.trouble',
      'plugins._devplugins',
    }

    plugload.loadfiles(files)
    --# Trial Plugins
    local trials = {
      --'trials.buffon',
      --'trials.hawtkeys',
      --'trials.better-escape',
      'trials.houdini', -- same as better-esc, so switching to it
      'trials.precognition', --technically enabled but lazy, would need to be manually command-triggered as is
      --'trials.nest',
      --'trials.racer-nvim',
      --'trials.split',
      --'trials.trailblazer',
    }

    --local trialLeap = require 'trials.leap_plus'(true, true, true, false)
    --plugload.add(trialLeap)
    plugload.loadfiles(trials)

    --# Conditional Plugins
    ----- dont need any right now
    plugload.getconditionals()

    --# Themes
    plugload.add(require('theme.themes').getlist { 'sierra', 'anderson', 'tender', 'ghostbuster', 'lucario', 'bogster', 'zephyr' })

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
      ui = { icons = vim.g.have_nerd_font and {} or require('plugins//storage').lazyicons },
    })
  end,
}

return D
