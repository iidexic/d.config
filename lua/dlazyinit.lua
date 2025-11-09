local D = {
  --NOTE: To make Lazy Reload work properly:
  -- switch to a "module" setup:
  -- change all files in plugin folder to exclusively return list of plugins
  -- then pass lazy setup the directory instead of the completed list of plugins
  LazyPluginSetup = function()
    local plugload = require 'pluginloader'

    --# Main Plugins
    local files = {
      'plugins.aerial',
      'plugins.bufferline',
      'plugins.diffview',
      'plugins.filemanager',
      'plugins.grapple',
      'plugins.hover',
      'plugins.lang-support',
      'plugins.layout',
      'plugins.lsp_lspsaga',
      'plugins.markdown',
      'plugins.mini',
      'plugins.obsidian',
      'plugins.persistence',
      'plugins.plugins_auto',
      'plugins.plugins_debug',
      'plugins.plugins_git',
      'plugins.plugins_keys',
      'plugins.plugins_lsp',
      'plugins.plugins_tools',
      'plugins.plugins_visual',
      'plugins.plugins_workflow',
      'plugins.precognition',
      'plugins.qol',
      'plugins.telescopes',
      'plugins.treesitters',
      'plugins.trouble',
      'plugins.ufo',
    }

    plugload.loadfiles(files)
    --# Trial Plugins
    local trials = {
      --'trials.hawtkeys',
      'trials.split', -- doesn't interfere with existing g mappings -- ok but what does it do
      --'trials.trailblazer',
      'trials.nvim_dev',
      'trials.neoclip',
      --'trials.origami',
      --'trials.glance',
      'trials.grug-far',
      --'trials.helpview',
      --'trials.iron',
      --'trials.nvim_dev',
      --'trials.plugin_bundle',
      --'trials.prettyhover',
      --'trials.supermaven_ai',
      --'trials.spectre'
      --'trials.tiny_inline_diagnostic',
    }

    -- local devplugs = require 'plugins._devplugins'
    -- plugload.loadmodule(devplugs)
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
        hererocks = true, -- set to `nil` to use hererocks when luarocks is not found.
      },
    })
    plugload.runsetup()
    plugload.N()
  end,
}

return D
