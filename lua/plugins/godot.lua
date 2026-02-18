return {
  {
    'Mathijs-Bakker/godotdev.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'mfussenegger/nvim-dap', 'rcarriga/nvim-dap-ui', 'nvim-treesitter/nvim-treesitter' },
    opts = {
      -- autostart_editor_server = true,
    },

    -- config = function()
    --   vim.lsp.config('godotdev', {
    --     editor_host = '127.0.0.1', -- Godot editor host
    --     editor_port = 6005, -- Godot LSP port
    --     debug_port = 6006, -- Godot debugger port
    --     -- csharp = true, -- Enable C# Installation Support
    --     autostart_editor_server = true, -- Enable auto start Nvim server
    --   })
    --   vim.lsp.enable('godotdev', true)
    -- end,
  },
}
