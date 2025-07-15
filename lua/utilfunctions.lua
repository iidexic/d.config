local M = {}

function M.tlen(t)
  local count = 0
  for k, _ in pairs(t) do
    count = count + 1
  end
  return count
end

-- remove. vim.print exists
--[[ function M.rtprint(t)
  if t[1] then
    for i, v in ipairs(t) do
      print(i, '->', v)
      if type(v) == 'table' then
        print '{'
        M.rtprint(v)
        print '}, '
      end
    end
  elseif M.tlen(t) > 0 then
    for k, v in pairs(t) do
      print(k, ': ', v)
      if type(v) == 'table' then
        print '={'
        M.rtprint(v)
        print '},'
      end
    end
  end
end ]]

--- function that wraps a different function in a function thingy
--- anyway, supports up to 5 args, if you need more then stop writing functions like that
--- not used, at all
---@param fn function
---@param args any[]
function M.wrapf(fn, args)
  -- not sure how to do this better without nested wrap via recursion. maybe I'll try that too
  if args and #args > 0 then
    local wtable = {
      function()
        fn(args[1])
      end,
      function()
        fn(args[1], args[2])
      end,
      function()
        fn(args[1], args[2], args[3])
      end,
      function()
        fn(args[1], args[2], args[3], args[4])
      end,
      function()
        fn(args[1], args[2], args[3], args[4], args[5])
      end,
    }
    return wtable[#args]
  end
  return function()
    fn()
  end
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

--#pcall plugin requires. unused, will probably be removed
M.maybeplug = {
  loadDone = false,
  _count_load = 0,
  failcalls = {},
  _tallyfails = function(plugin_name)
    if M.failcalls[plugin_name] then
      M.failcalls[plugin_name] = M.failcalls[plugin_name] + 1
    else
      M.failcalls[plugin_name] = 1
    end
  end,
}
---@type fun(plugin_name:string):table? @get require a module/plugin if it exists
---@param plugin_name string @name of plugin including standard path details
---@return table? @Returns the module requested or nil
function M.plugin(plugin_name)
  local allGood, m = pcall(require(plugin_name))
  if allGood then
    return m
  else
    return nil
  end
end

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
    -- I think this was just a nonsense function to check shit
    categorizee = function(tbl, d, l, sum) --#FOLD----------------
      for k, v in pairs(tbl) do
        if type(k) == 'string' then
          d[k] = v
          if type(v) == 'number' then
          elseif type(v) == 'string' then
            d.str = d.str .. v
          end
        elseif type(k) == 'number' then
          table.insert(l, v)
          if sum[k] then
            sum[k] = sum[k] + v
          else
            sum[k] = v
          end
        end
      end
    end,
    fnunctoin = function(n1, n2, tbl)
      table.insert(tbl, { n1, n2 })
      return (n1 * n2)
    end,
    -- TODO: add Plugin requires for luapad
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
