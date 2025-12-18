local M = {}

function M.path_sep()
  local sep = package.config:sub(1, 1)
  if sep == '\\' then
    return '\\'
  else
    return '/'
  end
end

function M.clean(path)
  local clean = path:gsub('\\', '/'):lower()
  return clean
end

--- check if path-standardized sub is a substring of path-standardized path
--- ex: has_subpath('/usr/local/bin', '/local') == true
--- ex: has_subpath('/usr/local/bin', 'al/bi') == true
function M.has_subpath(path, sub)
  local cpath = M.clean(path)
  local csub = M.clean(sub)
  if cpath:find(csub) then
    return true
  end
  return false
end

--- check if path is in parent
--- path and parent must both be absolute (or relative to the same root)
--- ex: is_parent('/usr/local/bin', '/usr/local') == true
--- ex: is_parent('/usr/local/bin', '/local') == false
function M.is_parent(path, parent)
  local cpath = M.clean(path)
  local cparent = M.clean(parent)
  local lenparent = cparent:len()
  return cpath:sub(1, lenparent) == cparent
end

return M
