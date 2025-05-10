local M = { -- Is this making shit more confusing? probably
  -- events
  -- **PersistenceSavePre**before saving a session
  -- **PersistenceSavePost**after saving a session
  persistAuto = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'PersistenceSavePre',
      desc = 'Avoid saving open neotree window',
      group = vim.api.nvim_create_augroup('persistence-save', { clear = true }),
      callback = function()
        require('neo-tree.command').execute { action = 'close' }
      end,
    })
  end,
  --[[
  whichkey_OnModeChange = function()
    vim.api.nvim_create_autocmd('user',{
      pattern = ''
    })
  end
  --]]
}

function M.post_autocmd()
  M.persistAuto()
end

return M
