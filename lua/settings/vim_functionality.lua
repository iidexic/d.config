local M = {}

local opt = {
  -- Force use last buffer in any window
  force_any_last_buffer = false,
  -- Quick-switch to last buffer in any window if current window has no history
  lastbuf_use_any = true,
}

local current_win = nil
local lastbuffer = { any = nil }
M.on_buf_leave = function() end

local function path_clean(path)
  return (path:gsub('\\', '/'))
end

--- OS temp dir, normalized to forward slashes and lowercased for comparison.
--- Windows: C:/Users/<you>/Appdata/Local/Temp -- Linux/mac: /tmp
local tempdir = path_clean(vim.fn.fnamemodify(vim.fn.tempname(), ':h:h')):lower()

--- true if `path` lives under the OS temp directory
local function is_temp_path(path)
  if type(path) ~= 'string' or path == '' then
    return false
  end
  return path_clean(path):lower():sub(1, #tempdir) == tempdir
end

M.autocommands = function()
  local autocmd = vim.api.nvim_create_autocmd
  local autogroup = require('settings.vim_util').autogroup
  autocmd('BufLeave', {
    pattern = { '*/*.*' },
    group = autogroup 'track-last-buffer',
    callback = function(event)
      -- Event has: - event(name) - match (full/path) - buf (bufnr) - file (full\path)
      -- Check if in cwd  (vim.uv.cwd()) if need stricter
      if not is_temp_path(event.match) then
        local win = vim.fn.win_getid()
        lastbuffer[win] = event.buf
        lastbuffer.any = event.buf
      end
    end,
  })
end

-- TODO: Finish function to identify buffers to be removed
-- (currently computes the three predicates but returns nothing)
M.is_buffer_non_user = function(bufnr)
  local bufname = vim.fn.bufname(bufnr)
  local is_noname = type(bufname) == 'string' and bufname:len() == 0
  local is_in_temp = is_temp_path(bufname)
  local is_in_cwd = bufname:find(vim.fn.getcwd(), 1, true) ~= nil
end

local function switchBufIfValid(buf, currentbuf)
  if not currentbuf then
    currentbuf = vim.fn.bufnr()
  end
  if vim.fn.buflisted(buf) == 1 and buf and buf ~= currentbuf then
    vim.api.nvim_set_current_buf(buf)
  end
end

M.switchToLastBuffer = function()
  local thisbuf = vim.fn.bufnr()
  local win = vim.fn.win_getid()
  if opt.force_any_last_buffer then
    switchBufIfValid(lastbuffer.any, thisbuf)
    return
  end
  if lastbuffer[win] then
    switchBufIfValid(lastbuffer[win], thisbuf)
  elseif opt.lastbuf_use_any then
    switchBufIfValid(lastbuffer.any, thisbuf)
  end
end

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
