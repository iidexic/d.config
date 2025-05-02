return {
  {
    'TheLazyCat00/racer-nvim',
    -- if opts is nil, lazy.nvim does not load the plugin
    opts = {
      triggers = {
        -- first element: key used to go backwards
        -- last element: key used to go forwards
        { '[', ']' },
        { 'F', 'f' },
      },
      -- allow other plugins to take over for certain keys
      -- this is useful for plugins like flash.nvim or leap.nvim
      -- keys specified here have to be also specified in the triggers section
      -- this example is for flash.nvim
      --external = {['f'] = require('flash.plugins.char').next, ['F'] = require('flash.plugins.char').prev, },
    },
    -- racer-nvim does not automatically configure the keymaps
    -- this is a design choice because this makes it more customizable
    keys = {
      { ';', "<cmd>lua require('racer-nvim').prev()<CR>", mode = { 'n', 'x' }, desc = 'Repeat previous' },
      { ',', "<cmd>lua require('racer-nvim').next()<CR>", mode = { 'n', 'x' }, desc = 'Repeat next' },
    },
  },
}
