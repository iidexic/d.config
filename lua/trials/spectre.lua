return {
  { -- in-(file? project?) find and replace tool 'a tool to replace text on project'
    'nvim-pack/nvim-spectre',
    -- might need sed. also trouble is a maybe but why not add it
    dependencies = { 'nvim-lua/plenary.nvim', 'folke/trouble.nvim' },
  },
}
