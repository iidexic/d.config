local M = {}

function M.rtprint(t)
  if t[1] then
    for i, v in ipairs(t) do
      print(i, ': ', v)
      if type(v) == 'table' then
        print '{'
        M.rtprint(v)
        print '}, '
      end
    end
  elseif #t > 0 then
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

return M
