local M = {}
M.path = {}

-- ── Table len ───────────────────────────────────────────────────────
function M.tlen(t)
  local count = 0
  for k, _ in pairs(t) do
    count = count + 1
  end
  return count
end

--# shorthand
M.sh = {
  auto = vim.api.nvim_create_autocmd,
  aug = function(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
  end,
}

M.luapad_global_table = function()
  local maintable = {
    t = require 'util.luapad_fixture',
    fnunctoin = function(n1, n2, tbl)
      table.insert(tbl, { n1, n2 })
      return (n1 * n2)
    end,
    plenary = require 'plenary',
  }
  maintable.plugs = function()
    local plugins_add = { 'plenary', 'lazy', 'telescope', 'ufo', 'bufferline', 'mason', 'luasnip', 'scratch', 'go', 'cmp' }
    local plugreqs = {}
    for _, plug in ipairs(plugins_add) do
      plugreqs[plug] = require(plug)
    end
    return plugreqs
  end
  return maintable
end

return M
