local D = {
  LazyPluginSetup = function()
    local plugload = require 'pluginloader'

    --# Main Plugins

    local files = {
      'plugins.aerial',
      'plugins.bufferline',
      'plugins.filemanager',
      'plugins.grapple',
      --'plugins.hover',
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
      --'trials.glance',
      --'trials.helpview',
      --'trials.iron',
      --'trials.nvim_dev',
      --'trials.plugin_bundle',
      --'trials.prettyhover',
      --'trials.supermaven_ai',
      --'trials.spectre'
      --'trials.tiny_inline_diagnostic',
    }
    --[[
-- ╭─────────────────────────────────────────────────────────╮
-- │                     Trials Results                      │
-- ╰─────────────────────────────────────────────────────────╯
-- 0. staying:
--    split, trailblazer, double-check what hawtkeys is
--    startup.nvim, neo-clip, precognition
-- 1. To main plugins:
--    'trials.aerial',
--    'trials.ufo',
--    'trials.houdini',
--    'trials.leap_plus',
--    'trials.persist',
--    'LspSaga' (in nvim_dev.lua)
-- 2. Grouped up and put in a single file
--    hot, hawtkeys, snacks
-- 3. Probably deleted
--    - nest
--    - peepsight (check if function is covered)
--    - racer-nvim (do one last check of the github)
--    - scretch
-- 4. Other:
--    - buffon: clone repo, make dev plug
--]]
    --# Check if dev plugs are present

    ---returns table of folder contents in the format {pathname, pathtype}
    ---@param path string # directory path
    ---@param check? table # {pathname, pathtype} to check for (for 2nd return val)
    ---@return table, boolean? # pathlist, if path `check` is in pathlist
    --@return boolean # path contains directory named lua
    local dir_contents = function(path, check)
      local ls = vim.fs.dir(path)
      local luadir = false
      local dirfiles = {}
      local fn, typ
      repeat
        fn, typ = ls()
        if fn then
          table.insert(dirfiles, { fn, typ })
          if check and { fn, typ } == check then
            luadir = true
          end
        end
      until not fn
      return dirfiles, luadir
    end

    local devplugs = require 'plugins._devplugins'
    local existing_dev_plugins = {}
    for i, plug in ipairs(devplugs) do
      local d, isplug = dir_contents(plug.dir, { 'lua', 'directory' })
      if isplug then
        table.insert(existing_dev_plugins, plug)
      end
    end
    if #existing_dev_plugins > 0 then
      plugload.loadmodule(existing_dev_plugins)
    end
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
