--
-- I don't think it will work with go; would need a new dir as part of template
return {
  {
    '0xJohnnyboy/scretch.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    -- or
    -- dependencies = { 'ibhagwan/fzf-lua' },
    opts = {
      -- Commented are defaults
      -- scretch_dir = vim.fn.stdpath 'config' .. '/scretch/', -- will be created if it doesn't exist
      -- template_dir = vim.fn.stdpath 'data' .. '/scretch/templates', -- will be created if it doesn't exist
      -- default_name = 'scretch_',
      -- default_type = 'txt', -- default unnamed Scretches are named "scretch_*.txt"
      -- split_cmd = 'vsplit', -- vim split command used when creating a new Scretch
      -- backend = 'telescope.builtin', -- also accpets "fzf-lua"
    },
  },
}
