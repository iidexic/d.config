local M = {}

M.plugins = {
  { 'iidexic/miss.nvim', dir = 'c:/dev/luaprojects/miss.nvim', dev = true, opts = { key_miss = '<leader>um' } },
  {
    'iidexic/dur.nvom',
    dir = 'c:/dev/luaprojects/dur.nvom/',
    dev = true,
    keys = function(self, keys)
      local map = {}
      return map
    end,
    opts = {},
  },
  { 'iidexic/material.nvim', dir = 'c:/dev/luaprojects/material.nvim/', dev = true, opts = {} },
}

return M.plugins
