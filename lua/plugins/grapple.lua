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
      opts = {
        scope = 'git', -- also try out "git_branch"
      },
      event = { 'BufReadPost', 'BufNewFile' },
      cmd = 'Grapple',
      --* LazyKeys spec: {'lhs','rhs', mode = 'm' | {'m','v'},[any opts from vim.keymap.set]}
      --  • "desc" human-readable description. --only keymap opt I need for now
      keys = {
        --TODO: lazy load when press semicolon, and then do functions elsewhere so we can do require(grapple)
        --TODO: move the  index select keys (q-f) out to where we can set desc as file name or not show if not set
        --TODO: add clear/cleanupz of set tags and some controls for scopes

        { ';m', '<cmd>Grapple toggle<cr>', desc = 'grapple toggle tag' },
        { ';M', '<cmd>Grapple toggle_tags<cr>', desc = 'grapple open tags window' },
        { ';n', '<cmd>Grapple cycle_tags next<cr>', desc = 'grapple cycle next tag' },
        { ';p', '<cmd>Grapple cycle_tags prev<cr>', desc = 'grapple cycle previous tag' },
        { ';`', '<cmd>Grapple  prune<cr>', desc = 'grapple prune scope' },
        { ';~', '<cmd>Grapple remove all<cr>', desc = 'grapple untag*' },

        { ';q', '<cmd>Grapple select index=1<cr>' },
        { ';w', '<cmd>Grapple select index=2<cr>' },
        { ';e', '<cmd>Grapple select index=3<cr>' },
        { ';r', '<cmd>Grapple select index=4<cr>' },
        { ';a', '<cmd>Grapple select index=5<cr>' },
        { ';s', '<cmd>Grapple select index=6<cr>' },
        { ';d', '<cmd>Grapple select index=7<cr>' },
        { ';f', '<cmd>Grapple select index=8<cr>' },
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
function M.gtagfn(n, gr)
  local a = gr.app()
  return function()
    if gr.exists { index = n } then
      local csid = a:current_scope().id
      local fnm = a.tag_manager.containers[csid]:get({ index = n }).path
      local name = vim.fs.basename(fnm)
      return '󱈤 ' .. name
    else
      return '󰓼 [no tag]'
    end
  end
end
function M.setup()
  local grap = require 'grapple'
  local gmap = {
    { ';q', '<cmd>Grapple select index=1<cr>', desc = M.gtagfn(1, grap) },
    { ';w', '<cmd>Grapple select index=2<cr>', desc = M.gtagfn(2, grap) },
    { ';e', '<cmd>Grapple select index=3<cr>', desc = M.gtagfn(3, grap) },
    { ';r', '<cmd>Grapple select index=4<cr>', desc = M.gtagfn(4, grap) },
    { ';a', '<cmd>Grapple select index=5<cr>', desc = M.gtagfn(5, grap) },
    { ';s', '<cmd>Grapple select index=6<cr>', desc = M.gtagfn(6, grap) },
    { ';d', '<cmd>Grapple select index=7<cr>', desc = M.gtagfn(7, grap) },
    { ';f', '<cmd>Grapple select index=8<cr>', desc = M.gtagfn(8, grap) },
    { ';;', grap.open_tags, desc = 'open tags' },
  }
  require('which-key').add(gmap)
end
M.g = Grap
return M
