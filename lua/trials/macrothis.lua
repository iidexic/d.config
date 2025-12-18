local function mtclosure(funcname)
  return function()
    require('macrothis')[funcname]()
  end
end
return {
  {
    'desdic/macrothis.nvim',
    opts = {},
    keys = {
      { '<Leader>kkd', mtclosure 'delete', desc = 'delete' },
      { '<Leader>kke', mtclosure 'edit', desc = 'edit' },
      { '<Leader>kkl', mtclosure 'load', desc = 'load' },
      { '<Leader>kkn', mtclosure 'rename', desc = 'rename' },
      { '<Leader>kkq', mtclosure 'quickfix', desc = 'run macro on all files in quickfix' },
      { '<Leader>kkr', mtclosure 'run', desc = 'run macro' },
      { '<Leader>kks', mtclosure 'save', desc = 'save' },
      { '<Leader>kkx', mtclosure 'register', desc = 'edit register' },
      { '<Leader>kkp', mtclosure 'copy_register_printable', desc = 'Copy register as printable' },
      { '<Leader>kkm', mtclosure 'copy_macro_printable', desc = 'Copy macro as printable' },
    },
  },
}
