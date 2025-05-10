---@generic NK: table|string
---@class NKeyDict<NK>: { [string]: NK }

--# Nested map structure
local nkex = {
  firstmotionkey = {
    secondmotionkey = {
      { 'third motionpart', ':cmd', 'description' },
      { 'third motion key', function() end, 'can use function as well' },
    },
    { 'sg', 'cmd', 'can put remainder of motion in one string as well' },
  },
  ['<leader>'] = { 'key2', 'cmd' },
  ['<c-s>'] = { 'mk', function() end, 'desc' },
} -- no idea how I will make this structure work though
_ = nkex
local wk = require 'which-key'
local function unwrapNest(key, NKmap, unwrap)
  if type(NKmap) == 'string' then
    --return key .. NKmap
  elseif type(NKmap) == 'table' then
  end
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
