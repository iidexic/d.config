return {
  { --> plugins_auto
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true, -- Autoinstall languages that are not installed
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' }, --  for indent problems, add lang to list of additional_vim_regex_highlighting and disabled languages for indent.
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
}
