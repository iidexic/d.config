local M = {}
local auto = vim.api.nvim_create_autocmd
M.agnames = {}
local make_augroup = function(name)
  table.insert(M.agnames, name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

M.make_autocommands = function()
  M.make_lspwatch_autocommand()

  vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    group = make_augroup 'kickstart-lsp-attach',
    callback = function(event)
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end
      map('<leader>r', vim.lsp.buf.rename, '[R]ename')
      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
      map('grf', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map('grd', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
      map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
      map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

      -- The following two autocommands are used to highlight references of hovered word
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        auto({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        auto({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        auto('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end
      -- toggle inlay hints mapping
      if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
        -- Disable Inlay hints By Default (idk where to do this)
        vim.lsp.inlay_hint.enable(false, {bufnr = event.buf})
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, '[T]oggle Inlay [H]ints')
      end

    end,
  })

end

M.make_lspwatch_autocommand = function()
  auto({ 'LspAttach' }, {
    group = make_augroup 'watch-lsp-attach',
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client then
        local allmatching = vim.lsp.get_clients({name = client.name})
        local cc = 0
        for _, c in ipairs(allmatching) do
          cc = cc + 1
        end
        if cc > 1 then
          vim.print('MULTI CLIENT MODE 󰱫 ')
        end
      end
    end
  })
end

return M
