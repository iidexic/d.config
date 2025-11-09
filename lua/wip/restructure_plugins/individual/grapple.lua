--- buffer? integer , path? string ,name? string, index? integer ,cursor? integer[],
--- scope? string, scope_id? string, command? fun(path: string)

local util = require 'utilfunctions'
local Grap = { set = false }
Grap.kd = function(n)
  if Grap.set then
    Grap.kd = Grap.key_description
    return Grap.key_description(n)
  else
    return ' '
  end
end

local M = {
  plugins = {
    {
      'cbochs/grapple.nvim',
      dependencies = 'folke/which-key.nvim',
      opts = {
        scope = 'git', -- also try out "git_branch"
      },
      event = { 'BufReadPost', 'BufNewFile' },
      cmd = 'Grapple',
      --* LazyKeys spec: {'lhs','rhs', mode = 'm' | {'m','v'},[any opts from vim.keymap.set]}
      --  • "desc" human-readable description. --only keymap opt I need for now
      keys = {
        { ';m', '<cmd>Grapple toggle<cr>', desc = 'grapple toggle tag' },
        { ';M', '<cmd>Grapple toggle_tags<cr>', desc = 'grapple open tags window' },
        { ';n', '<cmd>Grapple cycle_tags next<cr>', desc = 'grapple cycle next tag' },
        { ';p', '<cmd>Grapple cycle_tags prev<cr>', desc = 'grapple cycle previous tag' },
        { ';`', '<cmd>Grapple  prune<cr>', desc = 'grapple prune scope' },
        { ';~', '<cmd>Grapple remove all<cr>', desc = 'grapple untag*' },
      },
    },
  },
}

--============| Useful Info |=============
--/001 [cwd] Current working directory
--/002 [git] Git root directory
--/003 [git_branch] Git root directory and branch
--/004 [global] Global scope
--/005 [lsp] LSP root directory
--/006 [static] Initial working directory
--[[
Tagtable Format:
{ { cursor = {15, 2},--row/column
    path = "c:\\file\\path" } }
--]]

function M.makeGrappleMappings()
  ---@param n integer # grapple_index
  ---@return function # which-key mapping desc function
  local graptag = function(n)
    local gr = require 'grapple'
    return function()
      if gr.exists { index = n } then
        local csid = gr.app():current_scope().id
        local fnm = gr.app().tag_manager.containers[csid]:get({ index = n }).path
        local name = vim.fs.basename(fnm)
        return '󱈤 ' .. name
      else
        return '󰓼 [no tag]'
      end
    end
  end
  local gk = require('utilfunctions').grapple_key_list()
  local grap_map = {}
  for i, key in ipairs(gk) do
    local cmd_grapple = '<cmd>Grapple select index=' .. i .. '<cr>'
    table.insert(grap_map, i, {
      ';' .. key, ---{lhs}
      cmd_grapple, --{rhs}
      desc = graptag(i),
      --group = ';',
      --hidden = not M.gcondfn(i),
    })
  end
  return grap_map
end
function M.setup()
  -- removing
  local grap = require 'grapple'
  local gmap = {
    { ';q', '<cmd>Grapple select index=1<cr>', desc = M.gtagfn(1) },
    { ';w', '<cmd>Grapple select index=2<cr>', desc = M.gtagfn(2) },
    { ';e', '<cmd>Grapple select index=3<cr>', desc = M.gtagfn(3) },
    { ';r', '<cmd>Grapple select index=4<cr>', desc = M.gtagfn(4) },
    { ';t', '<cmd>Grapple select index=5<cr>', desc = M.gtagfn(5) },
    { ';a', '<cmd>Grapple select index=7<cr>', desc = M.gtagfn(6) },
    { ';s', '<cmd>Grapple select index=8<cr>', desc = M.gtagfn(7) },
    { ';d', '<cmd>Grapple select index=9<cr>', desc = M.gtagfn(8) },
    { ';f', '<cmd>Grapple select index=10<cr>', desc = M.gtagfn(9) },
    { ';g', '<cmd>Grapple select index=11<cr>', desc = M.gtagfn(10) },
    { ';z', '<cmd>Grapple select index=12<cr>', desc = M.gtagfn(11) },
    { ';x', '<cmd>Grapple select index=13<cr>', desc = M.gtagfn(12) },
    { ';c', '<cmd>Grapple select index=14<cr>', desc = M.gtagfn(13) },
    { ';v', '<cmd>Grapple select index=15<cr>', desc = M.gtagfn(14) },
    { ';b', '<cmd>Grapple select index=16<cr>', desc = M.gtagfn(15) },
    { ';;', grap.open_tags, desc = 'open tags' },
  }
  require('which-key').add(M.makeGrappleMappings()) -- gmap
end
M.g = Grap

return M
