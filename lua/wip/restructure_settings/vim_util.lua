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

return M
