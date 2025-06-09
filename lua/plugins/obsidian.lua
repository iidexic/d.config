local M = {}
M.plugin = {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    cond = false,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = '~/OneDrive/Apps/remotely-save/DVAULT',
        },
        --[[ {
          name = 'work',
          path = '~/vaults/work',
        }, ]]
      },

      -- see below for full list of options 👇
    },
    -- obs: also interfaces with obsidian I think? more for replacing obsidian. leave off for now probably
    --[[ {
      'IlyasYOY/obs.nvim',
      dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
      },
      enabled = false,
      --dev = true, --why...
      config = function()
        local obs = require 'obs'

        obs.setup {
          vault_home = '~/Notes',
          vault_name = 'Notes',
          journal = {
            template_name = 'daily',
          },
        }
      end,
    }, ]]
  },
}
-- if want to enable, change name to M.setup
M.obs_setup = function()
  -- For obs

  -- config for nvim-cmp
  local cmp = require 'cmp'
  local cmp_source = require 'obs.cmp-source'
  local obs = require 'obs'
  cmp.register_source('obs', cmp_source.new())

  -- config for obs.nvim
  local group = vim.api.nvim_create_augroup('ObsNvim', { clear = true })

  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    group = group,
    pattern = '*.md',
    desc = 'Setup notes nvim-cmp source',
    callback = function()
      if obs.vault:is_current_buffer_in_vault() then
        require('cmp').setup.buffer {
          sources = {
            { name = 'obs' },
            { name = 'luasnip' },
          },
        }
      end
    end,
  })
end
return M.plugin
