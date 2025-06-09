return {
  --==(ENABLED:)==--
  --> |mini.ai| [ check if covered by another workflow plugin ]
  --> |mini.files|
  --> |mini.icons| (exclusively for mini.files)
  --> |mini.surround| [ check if  covered by another workflow plugin ]
  --> |mini.jump2d| [ may be replaced by leap+extensions ]
  --> |mini.bufremove|
  --> |mini.tabline|
  --> |mini.statusline|
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.align').setup()
      require('mini.icons').setup() -- for mini.files specifically
      -- not disabling, I need this shit. alternatives?
      require('mini.surround').setup()
    end, -- and there is more! Check out: https://github.com/echasnovski/mini.nvim
  },
}
