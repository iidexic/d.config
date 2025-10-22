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
      { 'nvim-lua/plenary.nvim' },
      { 'salorak/whaler.nvim' },
      { 'cbochs/grapple.nvim' },
      { 'desdic/agrolens.nvim' },
      { 'jvgrootveld/telescope-zoxide' },
      { -- if get errors, see telescope-fzf-native readme for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make', -- only run on update/install
        cond = function() -- `cond` = condition; determine if plugin should be installed/loaded.
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function() -- [[ configure telescope ]] see `:help telescope` and `:help telescope.setup()`
      local telescope = require 'telescope'
      -- all the info you're looking for is in `:help telescope.setup()`
      telescope.setup {
        defaults = {
          mappings = { i = { ['<c-enter>'] = 'to_fuzzy_refine' } },
          layout_strategy = 'flex', -- horizontal | center | cursor | vertical | flex | bottom_pane
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          whaler = {
            auto_file_explorer = false,
            directories = {
              'c:\\dev',
              'c:\\dev\\python',
            },
            oneoff_directories = {
              { path = '~\\appdata\\local\\nvim', alias = 'nvim' },
            },
          },
          --* removing file_browser; superfluous
          --file_browser = { -- theme = 'ivy', hijack_netrw = true, mappings = {['i'] = {my_custom_insert_mappings}, ['n'] = {my_custom_normal-mode_mappings}} },
        },
      }

      pcall(telescope.load_extension, 'fzf') -- enable telescope extensions if they are installed
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'grapple')
      pcall(telescope.load_extension, 'whaler')
      pcall(telescope.load_extension, 'zoxide')
      pcall(telescope.load_extension, 'auto-session') -- most likely no worky
      pcall(telescope.load_extension, 'telescope-helpgrep')
      pcall(telescope.load_extension, 'agrolens')

      local builtin = require 'telescope.builtin' -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>st', builtin.tags, { desc = '[S]earch [T]ags' })
      vim.keymap.set('n', '<leader>sz', telescope.extensions.zoxide.list, { desc = '[S]earch [z]oxide list' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sm', telescope.extensions.grapple.tags, { desc = '[S]earch [M]arks->grapple' })
      vim.keymap.set('n', '<leader>sw', telescope.extensions.whaler.whaler, { desc = '[S]earch [w]haler paths' })
      vim.keymap.set('n', '<leader>sH', telescope.extensions.helpgrep.helpgrep, { desc = '[S]earch [H]elp with grep' })
      vim.keymap.set('n', '<leader>sc', builtin.colorscheme, { desc = '[S]earch [C]olorschemes' })
      vim.keymap.set('n', '<leader>sl', builtin.colorscheme, { desc = '[S]earch symbols agro[l]ens' })

      --unicode_picker. not a telescope extension directly but is a telescope command
      vim.keymap.set('n', '<leader>uu', '<cmd>Telescope unicode_picker<CR>', { desc = 'Unicode Picker' })

      local globaltags = function()
        local t = require 'telescope'
        local g = require 'grapple'
        vim.print(t.extensions.grapple.tags())
        t.extension.grapple.tags()
      end
      vim.keymap.set('n', '<leader>/', function()
        -- Slightly advanced example of overriding default behavior and theme
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      -- It's also possible to pass additional configuration options. See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      vim.keymap.set('n', '<leader>sn', function() -- Shortcut for searching your Neovim configuration files
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
}
