--- clears a package from the loaded table, then re-requires it and returns it
---@param packageName any
local function rerequire(packageName)
  if package.loaded[packageName] then
    package.loaded[packageName] = nil
    local pkg = require(packageName)
    vim.print('reloaded: ', packageName)
    return pkg
  end
  print('DWARNING: RELOAD FAILED\n PACKAGE `' .. package.loaded .. '` WAS NOT LOADED')
  return nil
end
local function reload_and_run(packageName, functionName)
  local pkg = rerequire(packageName)
  if pkg and pkg[functionName] then
    pkg[functionName]()
  end
end

local function renameAssist()
  local bufsPee = vim.api.nvim_list_bufs()
  local bufsWithChanges = {}

  local ltext = ''
  for i, b in ipairs(bufsPee) do
    if vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_get_option_value('modified', { buf = b }) then
      bufsWithChanges[vim.fn.bufname(b)] = b
    end
  end

  vim.lsp.buf.rename()
  -- LSP events:
  -- textDocument/prepareRename
  -- textDocument/rename
end

local function lazy_kill() end
local M = {}

M.map_vim_utils = function()
  require('which-key').add({
    -- Needs to re-require these
    {
      '<leader>Ra',
      function() -- no clue if this is functional lmao
        require('settings.autocommands').wipe_autos()

        reload_and_run('settings.autocommands', 'autocmd')
      end,
      desc = '[R]eload [a]utocommands',
    },
    {

      '<leader>Rm',
      function()
        reload_and_run('settings.mapping', 'assign')
      end,
      desc = '[R]eload [m]apping file',
    },
  }, { silent = true })
end
M.lazy_require = function()
  local lazy = require 'lazy'
  local util = require 'lazy.util'
  local manage = require 'lazy.manage'
  local pkg = require 'lazy.pkg'
  local pkglazy = require 'lazy.pkg.lazy'
  local minit = require 'lazy.minit'
  local state = require 'lazy.state'
  local community = require 'lazy.community'
  lazy.reload { 'material.nvim' }
end

return M
