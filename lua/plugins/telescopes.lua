-- [Telescope] - Fuzzy Finder
return {
  { 'catgoose/telescope-helpgrep.nvim', lazy = true },

  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font,
        config = function()
          require('nvim-web-devicons').set_icon {
            go = {
              icon = '󰟓 ',
              color = '#3ca7df',
              name = 'Go',
            },
          }
        end,
      },
      { 'nvim-lua/plenary.nvim' },
      { 'jvgrootveld/telescope-zoxide' },
      {
        'benfowler/telescope-luasnip.nvim',
        module = 'telescope._extensions.luasnip',
      },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1 and vim.fn.executable 'cc' == 1
        end,
      },
    },
    config = function()
      local telescope = require 'telescope'
      telescope.setup {
        defaults = { mappings = { i = { ['<c-enter>'] = 'to_fuzzy_refine' } }, layout_strategy = 'flex' },
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown {} },
        },
      }

      for _, ext in ipairs { 'fzf', 'ui-select', 'zoxide', 'telescope-helpgrep', 'luasnip' } do
        local ok, err = pcall(telescope.load_extension, ext)
        if not ok then
          vim.notify('telescope: failed to load extension "' .. ext .. '": ' .. tostring(err), vim.log.levels.WARN)
        end
      end
    end,
  },
}
