return {
  {
    'Mathijs-Bakker/godotdev.nvim',
    dependencies = { 'neovim/nvim-lspconfig', 'mfussenegger/nvim-dap', 'rcarriga/nvim-dap-ui', 'nvim-treesitter/nvim-treesitter' },
    -- These are godotdev.nvim's own options (see lua/godotdev/setup.lua), NOT a
    -- vim.lsp.config entry -- the plugin builds its LSP client itself.
    opts = {
      editor_host = '127.0.0.1', -- Godot editor host
      editor_port = 6005, -- Godot LSP port
      debug_port = 6006, -- Godot debugger port
      -- csharp = true, -- Enable C# Installation Support
      -- NOTE: this was previously set on the (broken) vim.lsp.config entry, so
      -- it never actually took effect. Now that the option reaches the plugin,
      -- `true` spawns a Godot editor server on EVERY nvim start and prints
      -- "Godot editor server already running on ...". Left at the plugin
      -- default; flip to true if you want the old stated intent.
      autostart_editor_server = false,
    },
  },
}
