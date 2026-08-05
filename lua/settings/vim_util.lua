local M = {}

M.autogroups_made = {}
-- TODO: Implement switching to buffer(s) last opened
-- Find the best event to use

--- Creates an autocommand group. clear = true by default.
--- names of all groups created by this function are stored in `vim_utils.autogroups_made`
---
---@param name string Name of the group
---@param override table|nil override config (currently only clear)
---@return number Group id
M.autogroup = function(name, override)
  local clearval = true
  if override and override.clear then
    clearval = override.clear
  end
  table.insert(M.autogroups_made, name)
  return vim.api.nvim_create_augroup(name, { clear = clearval })
end

--- clears a package from the loaded table, then re-requires it and returns it
---
---@param packageName any
function M.rerequire(packageName)
  -- Accept the opts table nvim_create_user_command hands its callback, so
  -- `:Rerequire settings.mapping` works as well as a direct lua call.
  if type(packageName) == 'table' then
    packageName = packageName.args
  end
  if type(packageName) ~= 'string' or packageName == '' then
    vim.notify('DWARNING: RELOAD FAILED\n no package name given', vim.log.levels.WARN)
    return nil
  end
  if package.loaded[packageName] then
    package.loaded[packageName] = nil
    local pkg = require(packageName)
    vim.print('reloaded: ', packageName)
    return pkg
  end
  -- was concatenating the `package.loaded` table itself, which throws
  vim.notify('DWARNING: RELOAD FAILED\n PACKAGE `' .. packageName .. '` WAS NOT LOADED', vim.log.levels.WARN)
  return nil
end
local function reload_and_run(packageName, functionName)
  local pkg = M.rerequire(packageName)
  if pkg and pkg[functionName] then
    pkg[functionName]()
  end
end

local function renameAssist()
  local bufsPre = vim.api.nvim_list_bufs()
  local bufsWithChanges = {}

  local ltext = ''
  for i, b in ipairs(bufsPre) do
    if vim.api.nvim_buf_is_loaded(b) and vim.api.nvim_get_option_value('modified', { buf = b }) then
      bufsWithChanges[vim.fn.bufname(b)] = b
    end
  end

  vim.lsp.buf.rename()
  -- LSP events:
  -- textDocument/prepareRename
  -- textDocument/rename
end

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
    {
      '<leader>Rf',
      function()
        M.rerequire 'settings.vim_functionality'
      end,
      desc = '[R]eload vim_functionality',
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
