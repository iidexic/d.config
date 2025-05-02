return {
  { 'ray-x/navigator.lua', dependencies = { 'neovim/nvim-lspconfig', { 'ray-x/guihua.lua' } } },
  {
    --==| GOLANG |==--
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-dap-ui',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  --TODO: Need to choose between goplements and gosigns? one is gutter.
  -- could probably use both. not sure if gosigns is going to be actually useful

  { -- visual display of interface implementation next to struct declaration
    'maxandron/goplements.nvim',
    enabled = true,
    ft = 'go',
    opts = {},
  },
  { -- visualize interface+struct+method implementation, and //go: comments. Very customizable
    'Yu-Leo/gosigns.nvim',
    enabled = false,
    ft = 'go',
    cmd = { 'GosignsEnable', 'GosignsDisable', 'GosignsToggle' },
    opts = {}, -- for default options. Refer to the configuration section for custom setup.
  },
  { -- run impl to generate interface method stubs, uses telescope
    -- <leader>gi has been assigned to run impl for now
    'edolphin-ydf/goimpl.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' },
      { 'nvim-telescope/telescope.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    -- NOTE: if having issues re-include this config function and remove from telescope side
    config = true, --function() require('telescope').load_extension 'goimpl' end,
  },
  {
    'crusj/structrue-go.nvim',
    branch = 'main',
    --requires gotags: `go get -u github.com/jstemmer/gotags`
  },
  -- godoc.nvim removed for now
  --==| GOLANG |==--
  { -- lua scratchpad, interactive repl type deal
    'rafcamlet/nvim-luapad',
    requires = 'antoinemadec/FixCursorHold.nvim',
  },
  { -- hot reloader for any plugin language, probably requires config
    'sachinsenal0x64/hot.nvim',
    config = function()
      local opts = require('hot.params').opts

      -- Update the Lualine Status
      Reloader = opts.tweaks.default
      Reloader = '💤'

      Pattern = opts.tweaks.patterns
      Pattern = { 'main.py', 'main.go', 'build.zig' }

      opts.tweaks.start = '🚀'
      opts.tweaks.stop = '💤'
      opts.tweaks.test = '🧪'
      opts.tweaks.test_done = '🧪.✅'
      opts.tweaks.test_fail = '🧪.❌'

      -- If the 'main.*' file doesn't exist, it will fall back to 'index.*'
      opts.tweaks.custom_file = 'index'

      -- Add Languages
      opts.set.languages.python = {
        cmd = 'python3',
        desc = 'Run Python file asynchronously',
        kill_desc = 'Kill the running Python file',
        emoji = '🐍',
        test = 'python -m unittest -v',
        ext = { '.py' },
      }

      opts.set.languages.go = {
        cmd = 'go run',
        desc = 'Run Go file asynchronously',
        kill_desc = 'Kill the running Go file',
        emoji = '🐹',
        test = 'go test',
        ext = { '.go' },
      }

      opts.set.languages.zig = {
        cmd = 'zig build run',
        desc = 'Build and Run Zig project asynchronously',
        kill_desc = 'kill the running Zig executable',
        emoji = ' ',
        ext = { '.zig' },
      }
      -- Thot Health Check
      --- the only thing this is useful for is making my h key slower to respond
      --- it literally just pulls up the list of the opts.set.languages above
      --vim.api.nvim_set_keymap('n', 'ho', '<Cmd>lua require("thot").check()<CR>', { noremap = true, silent = true })

      -- Keybinds

      -- Start
      vim.api.nvim_set_keymap('n', '<F3>', '<Cmd>lua require("hot").restart()<CR>', { noremap = true, silent = true })
      -- Silent
      vim.api.nvim_set_keymap('n', '<F4>', '<Cmd>lua require("hot").silent()<CR>', { noremap = true, silent = true })
      -- Stop
      vim.api.nvim_set_keymap('n', '<F5>', '<Cmd>lua require("hot").stop()<CR>', { noremap = true, silent = true })
      -- Test
      vim.api.nvim_set_keymap('n', '<F6>', '<Cmd>lua require("hot").test_restart()<CR>', { noremap = true, silent = true })
      -- Close Buffer
      vim.api.nvim_set_keymap('n', '<F8>', '<Cmd>lua require("hot").close_output_buffer()<CR>', { noremap = true, silent = true })
      -- Open Buffer
      vim.api.nvim_set_keymap('n', '<F7>', '<Cmd>lua require("hot").open_output_buffer()<CR>', { noremap = true, silent = true })

      -- Auto Reload on Save

      local save_group = vim.api.nvim_create_augroup('save_mapping', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePost', {
        desc = 'Reloader',
        group = save_group,
        pattern = Pattern,
        callback = function()
          require('hot').silent()
        end,
      })
    end,
  },
}
