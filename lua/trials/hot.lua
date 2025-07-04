return {
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
      opts.set.languages['python'] = {
        cmd = 'python3',
        desc = 'Run Python file asynchronously',
        kill_desc = 'Kill the running Python file',
        emoji = '🐍',
        test = 'python -m unittest -v',
        ext = { '.py' },
      }

      opts.set.languages['go'] = {
        cmd = 'go run',
        desc = 'Run Go file asynchronously',
        kill_desc = 'Kill the running Go file',
        emoji = '🐹',
        test = 'go test',
        ext = { '.go' },
      }

      opts.set.languages['zig'] = {
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
      vim.api.nvim_set_keymap('n', '<c-F3>', '<Cmd>lua require("hot").restart()<CR>', { noremap = true, silent = true })
      -- Silent
      vim.api.nvim_set_keymap('n', '<c-F4>', '<Cmd>lua require("hot").silent()<CR>', { noremap = true, silent = true })
      -- Stop
      vim.api.nvim_set_keymap('n', '<c-F5>', '<Cmd>lua require("hot").stop()<CR>', { noremap = true, silent = true })
      -- Test
      vim.api.nvim_set_keymap('n', '<c-F6>', '<Cmd>lua require("hot").test_restart()<CR>', { noremap = true, silent = true })
      -- Close Buffer
      vim.api.nvim_set_keymap('n', '<c-F8>', '<Cmd>lua require("hot").close_output_buffer()<CR>', { noremap = true, silent = true })
      -- Open Buffer
      vim.api.nvim_set_keymap('n', '<c-F7>', '<Cmd>lua require("hot").open_output_buffer()<CR>', { noremap = true, silent = true })

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
