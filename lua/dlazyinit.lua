local D = {
  --NOTE: To make Lazy Reload work properly:
  -- switch to a "module" setup:
  -- change all files in plugin folder to exclusively return list of plugins
  -- then pass lazy setup the directory instead of the completed list of plugins
  LazyPluginSetup = function()
    local plugload = require 'pluginloader'

    --# Main Plugins
    local files = {
      'plugins.ai', -- claude
      'plugins.aerial',
      'plugins.bufferline',
      'plugins.diffview',
      'plugins.blink',
      'plugins.dropbar',
      'plugins.filemanager',
      'plugins.conform',
      'plugins.iconpicker',
      -- 'plugins.grapple',
      'plugins.lang-support',
      'plugins.lsp_lspsaga',
      -- 'plugins.markdown',
      'plugins.mini',
      -- 'plugins.obsidian',
      'plugins.outline',
      'plugins.persistence',
      'plugins.plugins_debug',
      'plugins.plugins_git',
      'plugins.plugins_keys',
      'plugins.lsp.mason',
      'plugins.plugins_tools',
      'plugins.plugins_visual',
      'plugins.plugins_workflow',
      'plugins.python',
      -- 'plugins.precognition',
      'plugins.qol',
      'plugins.telescopes',
      'plugins.treesitters',
      'plugins.trouble',
      'plugins.ufo',
      'plugins.supermaven_ai',
      'plugins.godot',
    }

    -- ── Previously Removed from Above: ────────────────────────────────────
    --'plugins.hover',
    --'plugins.layout', -- none
    -- 'plugins.plugins_auto', --NOTE: trying to move to blink
    -- 'plugins.plugins_lsp',
    -- 'plugins.lsp.mason1',
    -- 'plugins.lsp_setup_new',
    -- ──────────────────────────────────────────────────────────────────────
    --'trials.split', -- splits lines on delimiters
    -- ──────────────────────────────────────────────────────────────────────

    plugload.loadfiles(files)
    --# Trial Plugins
    local trials = {
      --NEW:
      -- 'trials.snacks', -- DISABLED
      'trials.macrothis',
      'trials.grug-far',
      'trials.marks-nvim',
      'trials.helpview',

      --'trials.prettyhover', 'trials.spectre', 'trials.tiny_inline_diagnostic',
      --'trials.trailblazer', 'trials.origami', 'trials.glance', 'trials.hawtkeys',
      --'trials.helpview', 'trials.iron', 'trials.nvim_dev', 'trials.plugin_bundle',
    }

    local devplugs = require 'plugins._devplugins'
    plugload.loadmodule(devplugs)
    --leap
    local trialLeap = require 'trials.leap_plus'(true, true, false, true)
    plugload.loadmodule(trialLeap)
    plugload.loadfiles(trials)

    --# Themes
    plugload.add(require 'theme.themes')
    plugload.add(require 'theme.more-themes')
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
        -- nil = lazy.nvim will fall back to hererocks if system luarocks is missing.
        -- On Windows, system luarocks usually isn't present.
        hererocks = nil,
      },
    })
    plugload.runsetup()
    plugload.N()
  end,
}

return D
