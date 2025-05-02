local Nmap = {}
---@generic NK: table|string
---@class NKeyDict<NK>: { [string]: NK }

---@type NKeyDict
Nmap.keydict = {}

---Input/read nested map table
---@param nestedKeymap NKeyDict
function Nmap.read(nestedKeymap) end

return Nmap
