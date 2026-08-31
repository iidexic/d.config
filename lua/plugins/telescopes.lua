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
        build = (vim.fn.has 'win32' == 1)
            and 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
          or 'make',
        cond = function()
          if vim.fn.has 'win32' == 1 then
            return vim.fn.executable 'cmake' == 1
          end
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

      for _, ext in ipairs { 'fzf', 'ui-select', 'zoxide', 'helpgrep', 'luasnip' } do
        local ok, err = pcall(telescope.load_extension, ext)
        if not ok then
          vim.notify('telescope: failed to load extension "' .. ext .. '": ' .. tostring(err), vim.log.levels.WARN)
        end
      end
    end,
  },
}
