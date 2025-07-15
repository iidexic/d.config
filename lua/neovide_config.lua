vim = vim
local M = {}

M.neovide_config = function()
  -- check version
  vim.print(vim.g.neovide_version)
  -- set font/size options "Fontname,FallbackFontname:Opt1:Opt2" etc
  --  options:hX/wX, b,i bold/italic, #e-[font_alias_option] #h-[full|normal|slight|none] (HINTING)
  vim.o.guifont = 'ZedMono Nerd Font:h13:w0.2'
  -- change scaling (mostly font size)
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_text_gamma = -0.1
  vim.g.neovide_text_contrast = 0.3
  vim.print(vim.g.neovide_scale_factor)
end

return M
