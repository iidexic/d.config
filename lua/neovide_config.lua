vim = vim
local M = {}

M.neovide_config = function()
  -- check version
  vim.print(vim.g.neovide_version)
  -- set font/size options "Fontname,FallbackFontname:Opt1:Opt2" etc
  --  options:hX/wX, b,i bold/italic, #e-[font_alias_option] #h-[full|normal|slight|none] (HINTING)
  -- vim.o.guifont = 'EnvyCodeR Nerd Font:h15:w-0.2:#e-subpixelantialias'
  -- vim.o.guifont = 'spacemono Nerd Font:h14:w-0.6:#e-subpixelantialias'
  -- vim.o.guifont = 'd2codingligature Nerd Font:h16:w-0.2:#e-subpixelantialias'
  -- vim.o.guifont = 'ZedMono Nerd Font:h15:w0.2:#e-subpixelantialias'
  vim.o.guifont = 'ZedMono Nerd Font:h15:w0.2'
  -- change scaling (mostly font size)
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_text_gamma = -0.1
  vim.g.neovide_text_contrast = 0.4
  vim.print(vim.g.neovide_scale_factor)
end

return M
