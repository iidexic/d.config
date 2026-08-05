return {

  { -- legacy `master` branch: still works on 0.12, but is frozen upstream.
    -- The `main` branch is the actively developed one and has a different API
    -- (no `main = 'nvim-treesitter.configs'`, no `highlight`/`indent` opts) —
    -- see the commented-out spec below before switching.
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
    main = 'nvim-treesitter.configs', -- disable if errors
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'go',
        'gowork',
        'gomod',
        'gosum',
        'gotmpl',
        'json',
        'toml',
        'comment',
        'dart',
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
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
