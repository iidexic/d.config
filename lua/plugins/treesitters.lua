return {

  { -- Version to ensure Nvim 0.11 compatibility
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    main = 'nvim-treesitter.configs', -- disable if errors
    build = ':TSUpdate',
  },
  -- { -- Newer treesitter, probably requires 0.12
  --   'nvim-treesitter/nvim-treesitter',
  --   build = ':TSUpdate',
  --   lazy = false,
  --   --main = 'nvim-treesitter.configs', -- Sets main module to use for opts
  --   -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
  --   opts = {
  --     ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'go' },
  --     auto_install = true, -- Autoinstall languages that are not installed
  --     highlight = {
  --       enable = true,
  --       additional_vim_regex_highlighting = { 'ruby' }, --  for indent problems, add lang to list of additional_vim_regex_highlighting and disabled languages for indent.
  --     },
  --     indent = { enable = true, disable = { 'ruby' } },
  --   },
  -- },
  { -- Semshi (for python), off
    -- kickstart-python suggests both semshi and treesitter but looking at a comparison
    -- it's not a big enough difference for me to worry about having it
    'numirias/semshi',
    enabled = false,
  },
}
