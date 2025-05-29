return {
  { -- Option 1: Glance, kind of vscode-style, needs new mappings
    'dnlhc/glance.nvim',
    cmd = 'Glance',
    -- RECOMMENDED MAPPINGS:
    ---- vim.keymap.set('n', 'gD', '<CMD>Glance definitions<CR>')
    ---- vim.keymap.set('n', 'gR', '<CMD>Glance references<CR>')
    ---- vim.keymap.set('n', 'gY', '<CMD>Glance type_definitions<CR>')
    ---- vim.keymap.set('n', 'gM', '<CMD>Glance implementations<CR>')
    --NOTE: SORT OUT MAPPINGS BEFORE ENABLING!
    cond = false,
  },
  { -- Option 2, uses native lsp and may overwrite native lsp mappings (to use floating preview)
    -- which I am actually fine wit-
    'rmagatti/goto-preview',
    dependencies = { 'rmagatti/logger.nvim' },
    event = 'BufEnter',
    config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    cond = false,
  },
}
