local M = {}

function M.tlen(t)
  local count = 0
  for k, _ in pairs(t) do
    count = count + 1
  end
  return count
end

function M.rtprint(t)
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
end

---function that wraps a different function in a function thingy
---anyway, supports up to 5 args, if you need more then stop writing functions like that
---@param fn function
---@param args any[]
function M.wrapf(fn, args)
  -- I'm gonna be honest, IDK how to do this better without making a nested wrap via recursion. maybe I'll try that too
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

--#plugin-specific functions
function M.grappleKey(grapid)
  local grapkeys = { 'q', 'w', 'e', 'r', 'a', 's', 'd', 'f' }
  if type(grapid) == 'number' then
    return grapkeys[grapid]
  end
end
--# shorthand
M.sh = {
  auto = vim.api.nvim_create_autocmd,
  aug = function(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
  end,
}

--#dainty plugin calls
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

-- uh this just makes LazyDone loading into a latched bool in M.maybeplug
-- it also makes a command to see how many times (-1) LazyDone triggers; I would guess this happens only once
vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('maybeplug-lazy-check', { clear = true }),
  pattern = 'LazyDone',
  callback = function()
    if not M.maybeplug.loadDone then
      M.maybeplug.loadDone = true
      vim.api.nvim_create_user_command('HowManyLazyDone', function()
        vim.print(tostring(M._count_load) .. 'times LazyDone event triggered this sesh')
      end, {})
    else
      M._count_load = M._count_load + 1
    end
  end,
})

return M
