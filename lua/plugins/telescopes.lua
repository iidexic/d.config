-- [Telescope] - Fuzzy Finder
-- setup for telescope, currently direct table return
return {
  { 'catgoose/telescope-helpgrep.nvim', lazy = true },
  -- telescope extension. not sure if putting them all as dependencies for telescope is way 2 go

  -- ╭─────────────────────────────────────────────────────────╮
  -- │                                        Telescope Config │
  -- ╰─────────────────────────────────────────────────────────╯
  {
    'nvim-telescope/telescope.nvim',
    event = 'vimenter',
    dependencies = {
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font,
        config = function()
          require('nvim-web-devicons').set_icon_by_filetype {

            ['.go'] = {

              icon = '󰟓 ',
              color = '#3ca7df',
              --cterm_color = '65',
              name = 'Go',
            },
          }
        end,
      },
      { 'nvim-lua/plenary.nvim' },
      { 'salorak/whaler.nvim' },
      { 'cbochs/grapple.nvim' },
      { 'jvgrootveld/telescope-zoxide' },
      {
        'benfowler/telescope-luasnip.nvim',
        module = 'telescope._extensions.luasnip', -- if you wish to lazy-load
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim', -- Don't currently have working build system
        --build = 'make', -- only run on update/install
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release',
        cond = false, --function() return vim.fn.executable 'make' == 1 end,
      },
      { -- have not found a use for this
        'dedic/agrolens.nvim',
        event = 'VeryLazy',
        keys = {
          {
            'gl',
            function()
              require('agrolens').generate {}
            end,
            desc = 'generate agrolens query',
          },
        },
        cond = false,
      },
    },
    config = function()
      local telescope = require 'telescope'
      telescope.setup { -- layout_strategy = horizontal | center | cursor | vertical | flex | bottom_pane
        defaults = { mappings = { i = { ['<c-enter>'] = 'to_fuzzy_refine' } }, layout_strategy = 'flex' },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
            kind = { require 'icon-picker' },
          },
          whaler = {
            auto_file_explorer = false,
            directories = {
              'c:\\dev',
              'd:\\coding',
              { path = 'd:\\coding\\github', alias = 'projects (github)' },
              { path = 'c:\\dev\\zig', alias = 'zig' },
              { path = 'c:\\dev\\luaprojects', alias = 'lua projects' },
              'c:\\dev\\python',
              { path = 'c:\\dev\\.config', alias = '.config - backups' },
            },
            oneoff_directories = {
              { path = 'c:\\dev\\zig\\raylib-zig\\interlacer', alias = 'zig-rl interlacer' },
              { path = '~\\appdata\\local\\nvim', alias = 'nvim' },
              { path = '~\\appdata\\roaming\\neovide', alias = 'neovide config' },
              { path = 'd:\\coding\\github\\go-ca-experiments', alias = 'go ca' },
            },
          },
        },
      }

      --TODO: remove pcalls? Probably prefer an error
      pcall(telescope.load_extension, 'fzf') -- enable telescope extensions if they are installed
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'grapple')
      pcall(telescope.load_extension, 'whaler')
      pcall(telescope.load_extension, 'zoxide')
      pcall(telescope.load_extension, 'telescope-helpgrep')
      pcall(telescope.load_extension, 'luasnip')
      --pcall(telescope.load_extension, 'agrolens')

      --TODO: Move to mappings?
      local builtin = require 'telescope.builtin' -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'last [S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files' })
      vim.keymap.set('n', '<leader>sT', builtin.tags, { desc = '[S]earch [T]ags' }) -- have never used
      vim.keymap.set('n', '<leader>sq', builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
      vim.keymap.set('n', '<leader>sD', builtin.lsp_definitions, { desc = '[S]earch lsp [D]efinitions' })
      vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = '[S]earch [t]reesitter' })
      vim.keymap.set('n', '<leader>sz', telescope.extensions.zoxide.list, { desc = '[S]earch [z]oxide list' })
      vim.keymap.set('n', '<leader>sm', telescope.extensions.grapple.tags, { desc = '[S]earch [M]arks->grapple' })
      vim.keymap.set('n', '<leader>sw', telescope.extensions.whaler.whaler, { desc = '[S]earch [w]haler paths' })
      vim.keymap.set('n', '<leader>sH', telescope.extensions.helpgrep.helpgrep, { desc = '[S]earch [H]elp with grep' })
      vim.keymap.set('n', '<leader>sl', telescope.extensions.luasnip.luasnip, { desc = '[S]earch [l]uasnip snippets' })
      vim.keymap.set('n', '<leader>sc', builtin.colorscheme, { desc = '[S]earch [C]olorschemes' })
      vim.keymap.set('n', '<leader>sb', builtin.git_bcommits, { desc = '[S]earch [B]uffer Commit History' })
      vim.keymap.set('n', '<leader>sR', builtin.reloader, { desc = '[S]earch [R]eloader' })
      vim.keymap.set('n', 'gI', builtin.lsp_implementations, { desc = 'LSP:[G]oto [I]mplementation(s)' })
      --unicode_picker. not a telescope extension directly but is a telescope command
      vim.keymap.set('n', '<leader>uu', '<cmd>Telescope unicode_picker<CR>', { desc = 'Unicode Picker' })
      --vim.keymap.set('n', '<leader>sl', telescope.extensions.agrolens.agrolens, { desc = '[S]earch symbols agro[l]ens' })

      -- Below mappings from: Kickstart.nvim
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false })
      end, { desc = '[/] Fuzzily search in current buffer' })

      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep { -- see help for other config opts
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function() -- telescope search nvim config files
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      vim.keymap.set('n', '<leader>so', function() -- telescope search Obsidian notes
        builtin.find_files { cwd = '~/OneDrive/Apps/remotely-save/DVAULT/' }
      end, { desc = '[S]earch [O]bsidian notes' })
    end,
  },
}
