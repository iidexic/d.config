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

-- ╭─────────────────────────────────────────────────────────╮
--#│                plugin-specific functions                │
-- ╰─────────────────────────────────────────────────────────╯
function M.grapple_key_list()
  -- index == grapid
  return { 'q', 'w', 'e', 'r', 't', 'a', 's', 'd', 'f', 'g', 'z', 'x', 'c', 'v', 'b' }
end
function M.grappleKey(grapid)
  local grapkeys = { 'q', 'w', 'e', 'r', 't', 'a', 's', 'd', 'f', 'g', 'z', 'x', 'c', 'v', 'b' }
  if type(grapid) == 'number' and grapkeys[grapid] then
    if grapkeys[grapid] then
      return grapkeys[grapid]
    else
      return '[?]'
    end
  end
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
    t = { --#FOLD---------------
      dict = { one = 1, two = 2, three = '3', five = 'nan', four = nil },
      list = { 1, 'two', 3, 16, 'orange :)' },
      lnums = { 1513, 205, 9647, 135.0, 249.58, -369.4, 1035.135 },
      mixed = {
        'a',
        6,
        type = 'babinga',
        foo = function(txt)
          return ('foogy' .. txt) or 'foogy'
        end,
        bar = 'bar',
      },
      nest = {
        15,
        lvl = 1,
        cat = 'nested',
        val = 0,
        { 3, lvl = 2, val = 100, 'first one', { 'yes', ['a-b'] = false, cat = 'thingy', lvl = 3 } },
        cfg = { -1, 120, val = 4.169, lvl = 2 },
        { cat = { 'list', 'vals', lvl = 3 } },
      },
      nested = {
        tb1 = { win = true, lose = 'that sucks', 14, pct = 0.465479 },
        tb2 = { 4, 135, 93.845, src = 'nvim-luapad' },
        { 200, 201, 202, 203, 204 },
        'stringy',
        { 'table', 'of', 'strings' },
        tbl_of_strings = { stringOne = 'one', stringTwo = '2' },
      },
    },
    fnunctoin = function(n1, n2, tbl)
      table.insert(tbl, { n1, n2 })
      return (n1 * n2)
    end,
    plenary = require 'plenary',
    -- TODO: add real requires for luapad
  }
  maintable.plugs = function()
    require ''
    local plugins_add = { 'plenary', 'lazy', 'grapple', 'telescope', 'ufo', 'bufferline', 'mason', 'luasnip', 'scratch', 'go', 'cmp' }
    local plugreqs = {}
    for _, plug in ipairs(plugins_add) do
      plugreqs[plug] = require(plug)
    end
    return plugreqs
  end
  return maintable
end

return M
