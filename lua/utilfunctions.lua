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


return M

