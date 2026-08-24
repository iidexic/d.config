local M = {}



-- local function path_clean(path)
--   return (path:gsub('\\', '/'))
-- end

--- OS temp dir, normalized to forward slashes and lowercased for comparison.
--- Windows: C:/Users/<you>/Appdata/Local/Temp -- Linux/mac: /tmp
-- local tempdir = path_clean(vim.fn.fnamemodify(vim.fn.tempname(), ':h:h')):lower()

--- true if `path` lives under the OS temp directory
-- local function is_temp_path(path)
--   if type(path) ~= 'string' or path == '' then
--     return false
--   end
--   return path_clean(path):lower():sub(1, #tempdir) == tempdir
-- end

M.print_buf_detail = function()
  --local det = vim.fn.getbufinfo(vim.fn.bufnr())
  local bnum = vim.fn.bufnr()
  local b = 'BUFFER\n------------'
    .. '\nname: '
    .. vim.fn.bufname(bnum)
    .. '\nbufnr: '
    .. bnum
    .. '\ntype: '
    .. vim.fn.getbufvar(bnum, '&buftype')
    .. '\nwin id: '
    .. vim.fn.win_getid()
  vim.print(b)
end

-- TODO: remove both below; used as bandaid for an issue where gdscript (I think) files would run format and change after a write, causing the need for 2x `:w`. Just fix the issue if gdscript is going to be worked on often.
local writebuf = function()
  vim.schedule(function()
    vim.cmd 'silent! write'
  end)
end

M.format_and_save = function()
  require('conform').format { async = false, lsp_format = 'fallback' }
  writebuf()
end

return M
