-- mapping helper functions
vim.keymap.set('i', '<C-l>', '<esc><l><a>', { desc = 'edit shift right' })
local function cmd(s)
  return '<cmd>' .. s .. '<CR>'
end
local function dsc(s)
  return { desc = s }
end
local function ld(s)
  return '<leader>' .. s
end

local function toggletermFlip() -- assigned to alt-backslash in map.assign
  local term = require('toggleterm.terminal').get(1)
  if term and term.direction == 'horizontal' then
    term.change_direction(term, 'vertical')
  elseif term then
    term.change_direction(term, 'horizontal')
  end
end

---@ map_toggleterm sets mappings to be used in terminal
local function map_toggleterm()
  function _G.ttmap()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    --vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts) I think this making lazygit shit work bad
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    -- works only when term not selected/not open?
    --opts.desc = 'ToggleTermFlip' --vim.keymap.set('t', '<M-\\>', toggletermFlip, opts)
  end
  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd 'autocmd! TermOpen term://* lua ttmap()'
end
local maptables = {
  -- Trying whichkey-style above
  vismode = {
    --{ 'v', '<C-l>', vim.cmd },
  },
  go = { -- changed first key after leader to 'l'
    { '<leader>lr', cmd 'GoRun', dsc 'Go Run' },
    { '<leader>ld', cmd 'GoDoc', dsc 'GoDoc lookup' },
    { '<leader>la', cmd 'GoAlt', dsc 'Toggle to test file' },
    { '<leader>lf', cmd 'GoRun -F', dsc 'Go Run Floating window' },
    { '<leader>lb', cmd 'GoBuild', dsc 'Go Build to cwd' },
    { '<leader>lt', cmd 'GoTest -n', dsc 'Go Test selected' },
    { '<leader>lm', cmd 'GoModTidy', dsc 'Go Mod Tidy' },
    { '<leader>ln', cmd 'GoRename', dsc 'Go Rename symbol' },
    { '<leader>li', cmd 'GoImpl', dsc 'GoImpl' },
  },
}

local pluginmappings = {}

local function wkMapFromTable(mtable)
  local wk = require 'which-key'
  for _, mappings in pairs(mtable) do
    wk.add(mappings)
  end
end
local function tabpage_next()
  local nextpg = vim.api.nvim_get_current_tabpage() + 1
  if vim.api.nvim_tabpage_is_valid(nextpg) then
    vim.api.nvim_set_current_tabpage(nextpg)
  end
end
local function tabpage_prev()
  local prevpg = vim.api.nvim_get_current_tabpage() - 1
  if vim.api.nvim_tabpage_is_valid(prevpg) then
    vim.api.nvim_set_current_tabpage(prevpg)
  end
end
---@param n number tabpage number to go to
local function tabpage_goto(n)
  if vim.api.nvim_tabpage_is_valid(n) then
    vim.api.nvim_set_current_tabpage(n)
  end
end

local Map = {

  assign = function()
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') --  See `:help hlsearch`
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
    vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
    vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
    vim.keymap.set('n', '|', cmd 'lua MiniFiles.open()', dsc 'MiniFiles open')
    vim.keymap.set('n', '<M-\\>', toggletermFlip, dsc 'ToggleTerm Flip')
    vim.keymap.set('n', '<M-h>', tabpage_prev, dsc 'previous tabpage')
    vim.keymap.set('n', '<M-l>', tabpage_next, dsc 'next tabpage')

    -- make life a bit easier in insert mode
    map_toggleterm()
    --mapFromTable(maptables)
    wkMapFromTable(maptables)
    wkMapFromTable(pluginmappings)
  end,
}
function Map.p_commentbox()
  local cb = require 'comment-box'
  local km = {}
end
function Map.plugins()
  Map.wk = require 'which-key'
  local pr = require 'persistence'
  wk = Map.wk -- laziness
  wk.add {
    mode = 'n',
    {
      { ld 'Ps', pr.load, desc = 'Load cwd session' },
      { ld 'PS', pr.select, desc = 'Select session' },
      {
        ld 'Pl',
        function()
          pr.load { last = true }
        end,
        desc = 'Load last session',
      },
      { ld 'Pd', pr.stop, desc = 'Disable session save' },
    },
  }
  vim.keymap.set('n', '<leader>ga', function()
    require('tinygit').interactiveStaging()
  end, { desc = 'git add' })
  vim.keymap.set('n', '<leader>gc', function()
    require('tinygit').smartCommit()
  end, { desc = 'git commit' })
  vim.keymap.set('n', '<leader>gp', function()
    require('tinygit').push()
  end, { desc = 'git push' })
end

return Map
