local M = {}

function M.tabpage_next()
  local nextpg = vim.api.nvim_get_current_tabpage() + 1
  if vim.api.nvim_tabpage_is_valid(nextpg) then
    vim.api.nvim_set_current_tabpage(nextpg)
  end
end
function M.tabpage_prev()
  local prevpg = vim.api.nvim_get_current_tabpage() - 1
  if vim.api.nvim_tabpage_is_valid(prevpg) then
    vim.api.nvim_set_current_tabpage(prevpg)
  end
end
M.tabpage_on = nil

---@param n number tabpage number to go to
local function tabpage_goto(n)
  if vim.api.nvim_tabpage_is_valid(n) then
    vim.api.nvim_set_current_tabpage(n)
  end
end

function M.toggletermFlip() -- assigned to alt-backslash in map.assign
  local term = require('toggleterm.terminal').get(1)
  if term and term.direction == 'horizontal' then
    term.change_direction(term, 'vertical')
  elseif term then
    term.change_direction(term, 'horizontal')
  end
end

--TODO: Complete commentbox functionality, or remove
function M.commentbox()
  --write bool choice tbl
  local CB = {
    -- box: styles 1 to 22, line: styles 1 to 17
    box = { style = 1, pos = 'c', textpos = 'l' },
    line = { style = 1, pos = 'c', textpos = 'l' },
  }
  local presets = {
    defaults = {
      box = { style = 1, pos = 'c', textpos = 'l' },
      line = { style = 1, pos = 'c', textpos = 'l' },
    },
  }
  CB.edit = function(bl, opt, val)
    CB[bl][opt] = val
  end
  CB.write = function(cbnew)
    vim.tbl_deep_extend('force', {}, CB, cbnew)
  end
  vim.api.nvim_create_user_command('CBPref', function() end, {
    fargs = true,
  })
  --b 1,2,3 = rounded, square, heavy, 4 dashed, 7 double
  --b 12 = quote 13 = double lnquote, 18 vert enclose (L/R), 20 horiz enclose (top/btm)
  --l (2,3) rounded dwn/up, (4,5) square dwn/up,  (6,7,8) enclosed {[,(,<)]},
  --l 9 heavy ln , 12 weighted, 13 double
  --box: b-1, s-2 (square), q-12/13, ev-18,eh-20, h-9
  --[[ Ideally: set-up to toggle options (like box style # and alignment), but to also stay in a custom mode with custom keymap until command done ]]
end

M.init = function()
  M.tabpage_on = vim.api.nvim_get_current_tabpage()
  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('tab-nav', { clear = true }),
  })
  -- dont think this works
  -- BUG: bad code not good not work
  vim.api.nvim_create_user_command('ToTabPage', function() end, { count = vim.g:count() })
end
return M
