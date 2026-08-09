local M = {}

function M.toggle()
  local commentless = require 'commentless'
  local ok_ufo, ufo = pcall(require, 'ufo')
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  vim.w[win].commentless_saved = vim.w[win].commentless_saved
    or { foldlevel = vim.wo[win].foldlevel, foldminlines = vim.wo[win].foldminlines }
  if commentless.is_hidden() then
    commentless.toggle() -- reveal
    local saved = vim.w[win].commentless_saved or {}
    vim.wo[win].foldlevel = saved.foldlevel or 99
    vim.wo[win].foldminlines = saved.foldminlines or 1
    vim.w[win].commentless_saved = nil
    if ok_ufo then pcall(ufo.attach, buf) end
  else
    if ok_ufo then pcall(ufo.detach, buf) end
    vim.wo[win].foldmethod = 'expr'
    vim.wo[win].foldexpr = "v:lua.require'commentless.internal'.foldexpr()"
    vim.wo[win].foldlevel = 0
    vim.wo[win].foldminlines = 0
    commentless.toggle() -- hide (runs zx)
  end
end

return M
