local M = {}

--- Get list of all keys (chars) to use with grapple.nvim
function M.grapple_key_list()
  return { 'q', 'w', 'e', 'r', 't', 'a', 's', 'd', 'f', 'g', 'z', 'x', 'c', 'v', 'b' }
end

-- ╭───────────────────────── Grapple Functions ─────────────────────────╮
--- Convert a grapple tag id to a key string
--- @param grapid number
--- @return string
function M.grappleKey(grapid)
  local grapkeys = { 'q', 'w', 'e', 'r', 't', 'a', 's', 'd', 'f', 'g', 'z', 'x', 'c', 'v', 'b' }
  if type(grapid) == 'number' and grapkeys[grapid] then
    if grapkeys[grapid] then
      return grapkeys[grapid]
    end
  end
  return ''
end
-- ╰────────────────────────────────────────────────────────────────────╯
