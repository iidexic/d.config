---@generic NK: table|string
---@class NKeyDict<NK>: { [string|integer]: NK } # freeform table of nested/regular mappings
---@field run function()|string|table

local cmd = function(str)
  return '<cmd>' .. str .. '<CR>'
end
--# Nested map structure
-- to bind '<':
-- Anything in < > will be taken as
local nkex = {
  firstmkey = {
    secondmkey = {
      { 'third motionpart', ':cmd', 'description' },
      { 'third motion key', function() end, 'can use function as well' },
    },
    { 'sg', 'cmd', 'can put remainder of motion in one string as well' },
  },
  ['<leader>'] = { 'key2', 'cmd' },
  ['<c-s>'] = { 'mk', function() end, 'desc' },
} -- no idea how I will make this structure work though
_ = nkex
local nktest = {
  { 't', '<C-j>', [[<Cmd>wincmd j<CR>]], 'terminal mode: move to window down' },
  { '<leader>q', vim.diagnostic.setloclist },
  { '<Esc>', '<cmd>nohlsearch<CR>' },
  { '<C-h>', '<C-w><C-h>', 'Move focus to the left window' },
  { '|', cmd 'lua MiniFiles.open()', 'MiniFiles open' },
  { '<M-\\>', function() end, 'ToggleTerm Flip' },
}
local wk = require 'which-key'
local function unwrapNest(key, nmap, unwrap)
  unwrap = unwrap .. key
end
local Nmap = {}

---@type NKeyDict
Nmap.keydict = {}
---Input/read nested map table
---@param nestedKeymap NKeyDict
function Nmap.read(nestedKeymap)
  if not Nmap.uwmap then
    Nmap.uwmap = {}
  end
  for k, v in pairs(nestedKeymap) do
    unwrapNest(k, v, Nmap.uwmap)
  end
end

return Nmap
