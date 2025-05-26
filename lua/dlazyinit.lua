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
      'plugins.grapple',
      'plugins.obsidian',
      'plugins.qol',
      'plugins.filemanager',
      'plugins.plugins_auto',
      'plugins.plugins_keys',
      'plugins.plugins_tools',
      'plugins.plugins_visual',
      'plugins.plugins_workflow',
      'plugins.bufferline',
      'plugins.telescopes',
      'plugins.plugins_git',
      'plugins.treesitters',
      'plugins.trouble',
      'plugins._devplugins',
    }

    plugload.loadfiles(files)
    --# Trial Plugins
    local trials = {
      'trials.aerial',
      --'trials.buffon',
      --'trials.hawtkeys',
      'trials.houdini', -- move to fulltime
      'trials.precognition', -- good to have. add to utilities binds
      --'trials.nest',
      --'trials.split',
      --'trials.trailblazer',
      'trials.plugin_bundle',
    }

    --leap
    local trialLeap = require 'trials.leap_plus'(true, true, true, false)
    plugload.loadmodule(trialLeap)
    plugload.loadfiles(trials)

    --# Themes
    plugload.add(require('theme.themes').themelist)
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
      change_detection = { enabled = true, notify = true },

      rocks = {
        enabled = true,
        root = vim.fn.stdpath 'data' .. '/lazy-rocks',
        server = 'https://nvim-neorocks.github.io/rocks-binaries/',
        -- use hererocks to install luarocks
        hererocks = true, -- set to `nil` to use hererocks when luarocks is not found (this wasnt workin before)
      },
    })
    plugload.runsetup()
    plugload.N()
  end,
}

return D
