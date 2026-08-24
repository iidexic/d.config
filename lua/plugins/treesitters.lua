return {

  { -- legacy `master` branch: frozen upstream, and NOT fully 0.12-clean —
    -- see the compat shim in `config` below.
    -- The `main` branch is the actively developed one and has a different API
    -- (no `main = 'nvim-treesitter.configs'`, no `highlight`/`indent` opts) —
    -- see the commented-out spec below before switching.
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    lazy = false,
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
        'sql',
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- Override the `sql` parser to track the upstream `main` branch.
      -- nvim-treesitter master pins tree-sitter-sql to a `gh-pages` revision
      -- (b9d1095) that predates the `create_policy` node. aerial.nvim's SQL
      -- query references that node, so opening any Supabase/PG file that would
      -- normally match produces:
      --   query.lua:374: Query error at 37:2. Invalid Node Type "create_policy"
      -- Run `:TSUpdate sql` after this change to rebuild.
      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.sql = {
        install_info = {
          url = 'https://github.com/derekstride/tree-sitter-sql',
          files = { 'src/parser.c', 'src/scanner.c' },
          branch = 'main',
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = 'sql',
      }

      -- 0.12 compat shim. `add_predicate`/`add_directive` no longer honour the
      -- `all` option — they read only `force`. master registers every handler
      -- with `{ force = true, all = false }` (query_predicates.lua:19), so its
      -- handlers now receive `table<integer, TSNode[]>` where they index
      -- `match[id]` as a single TSNode. Any markdown fenced block with a
      -- language tag hits this through `#set-lang-from-info-string!`:
      --   treesitter.lua:197: attempt to call method 'range' (a nil value)
      -- (blink.cmp's path-source doc preview wraps files in ```<ext> fences,
      -- which is how it shows up while completing paths.)
      -- Re-register master's handlers through a wrapper that unwraps the lists.
      -- Delete this whole block when moving to the `main` branch — it registers
      -- only `kind-eq?`/`any-kind-eq?`, both already list-aware.
      local tsq = require 'vim.treesitter.query'
      local add_predicate, add_directive = tsq.add_predicate, tsq.add_directive

      local function unwrap(handler)
        return function(match, ...)
          local first = {}
          for id, nodes in pairs(match) do
            first[id] = type(nodes) == 'table' and nodes[1] or nodes
          end
          return handler(first, ...)
        end
      end

      local function patched(add)
        return function(name, handler, o)
          if type(o) == 'table' and o.all == false then
            handler = unwrap(handler)
          end
          return add(name, handler, o)
        end
      end

      tsq.add_predicate, tsq.add_directive = patched(add_predicate), patched(add_directive)
      package.loaded['nvim-treesitter.query_predicates'] = nil
      require 'nvim-treesitter.query_predicates'
      tsq.add_predicate, tsq.add_directive = add_predicate, add_directive

      require('nvim-treesitter.configs').setup(opts)
    end,
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
