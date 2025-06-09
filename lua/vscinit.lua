-- ── Differences from regular nvim config: ───────────────────────────
-- plugins/files removed:
---- git plugins, lspsaga, markdown, plugins_auto(autocomplete)
---- don't need themes
-- Most likely will remove:
---- debug plugins, precognition, persistence, telescope, trouble, ufo
-- ────────────────────────────────────────────────────────────────────
local M = {}

function M.init()
  M.preconfig()
  M.lazysetup()
  M.postconfig()
end

local cfg = require 'vsc.vimconfig'
function M.preconfig()
  cfg.first()
end

function M.lazysetup()
  local pfiles = {
    'plugins.persistence',
    'plugins.plugins_debug', -- functional or in use at all? Esp. for vscode
    'plugins.plugins_keys',
    'plugins.precognition', -- functional in vscode?
    'plugins.treesitters',
    'plugins.trouble', -- functional in vscode?
    'plugins.ufo', -- functional in vscode?
    'trials.neoclip',
    'vsc.indent-blankline', --Not actually different from standard indent-blankline?
    'vsc.leap',
    'vsc.lsp', --* May need LSP for lsp-based actions
    'vsc.mini',
    'vsc.qol',
    'vsc.telescopes', -- functional in vscode?
    'vsc.visual',
    'vsc.workflow',
  }
  local plugload = require 'pluginloader'
  plugload.loadfiles(pfiles)
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
  require('lazy').setup(plugload.allplugins, {
    ui = {
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
end

function M.postconfig()
  local map = require 'vsc.mapping'
  cfg.last()
  map.assign()
  map.plugins()
end
return M
