local M = {}

local autocmd = vim.api.nvim_create_autocmd
local autogroup = require('settings.vim_util').autogroup

-- function M.joker_autocmd()
--   local plist = {
--     'MiniFilesExplorerOpen',
--     'MiniFilesExplorerClose',
--     'MiniFilesBufferCreate',
--     'MiniFilesBufferUpdate',
--     'MiniFilesWindowOpen',
--   }
--   for _, p in ipairs(plist) do
--     autocmd('User', {
--       pattern = p,
--       group = autogroup('group-' .. p),
--       callback = function()
--         vim.notify('triggered ' .. p)
--       end,
--     })
--   end
-- end
--
function M.print_tbl(tbl)
  for k, v in pairs(tbl) do
    vim.print(k, v)
    if type(v) == 'table' then
      M.print_tbl(v)
    end
  end
end
-- M.post_autocmd = function()
--   vim.api.nvim_create_autocmd('User', {
--     pattern = { 'MiniFilesExplorerOpen', 'MiniFilesBufferCreate' },
--     desc = 'add additional close mapping to minifiles',
--     group = autogroup('minigroup-make-map-on-open', { clear = true }),
--     callback = function(args)
--       vim.keymap.set('n', 'q', require('mini.files').close, { desc = 'close explorer', buffer = args.buf_id })
--       vim.keymap.set('n', '<CR>', function()
--         require('mini.files').go_in { close_on_file = true }
--       end, { desc = 'open file (go in plus)', buffer = args.buf_id })
--       -- end
--     end,
--   })
-- end

return M
