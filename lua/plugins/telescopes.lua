-- [Telescope] - Fuzzy Finder
-- setup for telescope, currently direct table return
-- before that, check insert functionality

return {
  {
    'cbochs/grapple.nvim',
    opts = {
      scope = 'git', -- also try out "git_branch"
    },
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = 'Grapple',
    keys = {
      { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
      { '<leader>M', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple open tags window' },
      { '<leader>n', '<cmd>Grapple cycle_tags next<cr>', desc = 'Grapple cycle next tag' },
      { '<leader>p', '<cmd>Grapple cycle_tags prev<cr>', desc = 'Grapple cycle previous tag' },
    },
  },
  { 'desdic/agrolens.nvim' }, -- telescope extension. not sure if putting them all as dependencies for telescope is way 2 go
  --=======================[ Telescope Config ]=======================--
  --==================================================================--
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'SalOrak/whaler.nvim' },
      { 'cbochs/grapple.nvim' },
      { 'jvgrootveld/telescope-zoxide' },
      { -- If get errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make', -- only run on update/install
        cond = function() -- `cond` = condition; determine if plugin should be installed/loaded.
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function() -- [[ Configure Telescope ]] See `:help telescope` and `:help telescope.setup()`
      local telescope = require 'telescope'
      telescope.setup { -- All the info you're looking for is in `:help telescope.setup()`
        -- defaults = { mappings = { i = { ['<c-enter>'] = 'to_fuzzy_refine' }}},
        -- pickers = {} -- what are pickers
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          agrolens = { -- Defaults:
            --debug = false, same_type = true, include_hidden_buffers = false,
            --disable_indentation = false, aliases = {},
          },
          whaler = {
            auto_file_explorer = false,
            directories = {
              'c:\\dev',
              'd:\\Coding',
              { path = 'd:\\Coding\\github', alias = 'projects (github)' },
              { path = 'c:\\dev\\zig', alias = 'zig' },
              'c:\\dev\\lua',
              'c:\\dev\\python',
              { path = 'c:\\dev\\.config', alias = '.config - backups' },
            },
            oneoff_directories = {
              { path = 'c:\\dev\\zig\\raylib-zig\\inteRLacer', alias = 'zig-rl interlacer' },
              { path = '~\\appdata\\Local\\nvim', alias = 'nvim' },
              { path = '~\\appdata\\roaming\\neovide', alias = 'neovide config' },
              { path = 'd:\\Coding\\github\\go-CA-experiments', alias = 'go CA' },
            },
          },
          --* removing file_browser; superfluous
          --file_browser = { -- theme = 'ivy', hijack_netrw = true, mappings = {['i'] = {my_custom_insert_mappings}, ['n'] = {my_custom_normal-mode_mappings}} },
        },
      }

      pcall(telescope.load_extension, 'fzf') -- Enable Telescope extensions if they are installed
      pcall(telescope.load_extension, 'ui-select')
      pcall(telescope.load_extension, 'grapple')
      pcall(telescope.load_extension, 'whaler')
      pcall(telescope.load_extension, 'zoxide')
      pcall(telescope.load_extension, 'auto-session') -- most likely no worky
      pcall(telescope.load_extension, 'agrolens')
      pcall(telescope.load_extension, 'goimpl')

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
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>sz', telescope.extensions.zoxide.list, { desc = '[S]earch [z]oxide list' })
      vim.keymap.set('n', '<leader>sm', telescope.extensions.grapple.tags, { desc = '[S]earch Gr[m]apple tags' })
      vim.keymap.set('n', '<leader>sw', telescope.extensions.whaler.whaler, { desc = '[S]earch [w]haler paths' })

      vim.keymap.set('n', '<leader>gi', telescope.extensions.goimpl.goimpl, { desc = '[G]o[I]mpl' })

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
  {
    'rmagatti/auto-session',
    lazy = false,
    keys = { -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { '<leader>wl', '<cmd>SessionSearch<CR>', desc = 'Session [l]ens' },
      { '<leader>wr', '<cmd>SessionSave<CR>', desc = 'Save session' },
      { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle [a]utosave' },
    },
    dependencies = { { 'nvim-telescope/telescope.nvim' } },

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      session_lens = {
        load_on_setup = true,
        previewer = false,
        mappings = {
          -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
          delete_session = { 'i', '<C-D>' },
          alternate_session = { 'i', '<C-S>' },
          copy_session = { 'i', '<C-Y>' },
        },
      },
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '~\\appdata\\local\nvim', 'd:\\coding\\github', 'c:\\dev' },
    },
  },
}

--[[#buffer close function; implement this later
local m = {}
m.my_buffer = function(opts)
  opts = opts or {}
  opts.attach_mappings = function(prompt_bufnr, map)
    local delete_buf = function()
      local selection = action_state.get_selected_entry()
      actions.close(prompt_bufnr)
      vim.api.nvim_buf_delete(selection.bufnr, { force = true })
    end
    map('i', '<c-u>', delete_buf)
    return true
  end
  opts.previewer = false
  -- define more opts here
  -- opts.show_all_buffers = true
  -- opts.sort_lastused = true
  -- opts.shorten_path = false
  require('telescope.builtin').buffers(require('telescope.themes').get_dropdown(opts))
end
--]]
