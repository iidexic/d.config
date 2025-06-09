-- mapping helper functions
-- VScode Version:
--  No toggleter,
--  No lsp plugins
--  No UI plugins
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

--- Which-key add all tables of mappings in mtable
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
local maptables = {
  -- Trying whichkey-style above
  vismode = {
    --{ 'v', '<C-l>', vim.cmd },
  },
  --NOTE: Thinking all mappings should be after lazy init?
  --      I don't think descriptions here go to which-key.
  --      Which-key description for go mappings is just using command name
  assigns = {
    --{ '<leader>q', vim.diagnostic.setloclist, dsc 'Quickfix list' }, -- moving to Trouble.
    { '<Esc>', '<cmd>nohlsearch<CR>' },
    { '<C-h>', '<C-w><C-h>', dsc 'Move focus to the left window' },
    { '<C-k>', '<C-w><C-k>', dsc 'Move focus to the upper window' },
    { '<C-l>', '<C-w><C-l>', dsc 'Move focus to the right window' },
    { '<C-j>', '<C-w><C-j>', dsc 'Move focus to the lower window' },
    { '<M-h>', tabpage_prev, dsc 'previous tabpage' },
    { '<M-l>', tabpage_next, dsc 'next tabpage' },
    -- -- this is going to be set in autocommands,
    --[[ { 'gh', function() vim.lsp.buf.signature_help { max_width = 86, max_height = 30 } end, dsc 'show signature help. (hover="KK")', }, ]]
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
    { '<leader>lI', cmd 'GoImpl', dsc 'GoImpl' },
  },
}
local Map = {
  assign = function()
    vim.keymap.set('v', '<A-r>', ':lua<CR>', { desc = 'run selected lua code' })
    wkMapFromTable(maptables)
  end,
}

function Map.plugins()
  Map.wk = require 'which-key'
  local pr = require 'persistence'
  Map.wk.add {
    mode = 'n',
    {
      -- Uncertain if functional in vscode
      { ld 'ps', pr.load, desc = 'Load cwd session' },
      { ld 'pS', pr.select, desc = 'Select session' },
      {
        ld 'pl',
        function()
          pr.load { last = true }
        end,
        desc = 'Load last session',
      },
      { ld 'pd', pr.stop, desc = 'Disable session save' },
    },
  }
  local mappingFunctions = { Map.vim, Map.other_plugins, Map.leap, Map.commentbox, Map.configReloads }
  for _, mfn in ipairs(mappingFunctions) do
    Map.wk.add(mfn())
  end
end
-- ── MappingFunctions ────────────────────────────────────────────────
function Map.vim()
  return {
    { 'gl', vim.lsp.buf.incoming_calls(), desc = 'show incoming calls to symbol under cursor' },
  }
end

function Map.configReloads()
  local cmap = {
    { '<leader>Ra', require('settings.autocommands').post_autocmd, desc = '[R]eload [a]utocommands' },
    {
      '<leader>Rm',
      function()
        Map.assign()
        Map.plugins()
      end,
      desc = '[R]erun [m]appings file',
    },
  }
  return cmap
end

function Map.commentbox()
  local km = {
    { 'gCb', cmd('CBlcbox ' .. 1) },
    { 'gCl', cmd 'CBllline ' .. 1 },
    { 'gCs', cmd 'CBlcbox ' .. 2 },
    { 'gCq', cmd('CBlcline ' .. 2) },
  }
  return km
end
function Map.other_plugins()
  -- work in vscode?
  local precog = require 'precognition'
  --local neoclip = require 'neo' -- not removed, just haven't added mappings yet
  --  aerial removed, render markdown removed
  local m = {
    -- Precognition
    { ld 'up', precog.toggle, desc = '[U]til: [p]recognition toggle' },
    -- Trevj. breaks a line out to multiple lines
    { '<A-j>', require('trevj').format_at_cursor, desc = 'breakout list to lines' },
  }
  return m
end
function Map.leap()
  return { -- leap still good to go
    { 'S', '<Plug>(leap-anywhere)', desc = 'leap anywhere' },
    { '<C-s>', '<Plug>(leap)', desc = 'leap', mode = { 'i', 'n' } },
  }
end

return Map
