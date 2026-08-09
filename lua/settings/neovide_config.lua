local M = {}

--- Mono nerd fonts installed on this machine (verified with `fc-list :spacing=100`).
--- Keep these in sync with what fontconfig actually reports; a missing family
--- silently falls back and the width tweaks stop making sense.
local fonts = {
  envycoder = 'EnvyCodeR Nerd Font Mono:h14:w0', -- :#e-subpixelantialias
  fantasque = 'FantasqueSansM Nerd Font Mono:h14.0:w-0.6', -- [L]
  hack = 'Hack Nerd Font Mono:h13.0:w-1.0',
  inputmono = 'InputMono Nerd Font:h13.4:w-0.8',
  inputcompressed = 'InputMonoCompressed Nerd Font:h14.6:w-0.6',
  -- inputcondensed = 'InputMonoCondensed Nerd Font:h14.0:w-0.8',
  inputnarrow = 'InputMonoNarrow Nerd Font:h13.8:w-0.6',
  iosevka = 'Iosevka Nerd Font Mono:h14.0:w0',
  iosevkaterm = 'IosevkaTerm Nerd Font Mono:h13.0:w-0.0',
  jetbrains = 'JetBrainsMono Nerd Font Mono:h12.4:w-0.4', -- [L]
  -- jetbrainsnl = 'JetBrainsMonoNL Nerd Font Mono:h12.4:w-0.6',
  m1code = 'M+1Code Nerd Font Mono:h13.3:w-0.0',
  mcodelat50 = 'M+CodeLat50 Nerd Font Mono:h13.4:w-0.2',
  -- mcodelat60 = 'M+CodeLat60 Nerd Font Mono:h13.4:w-0.2',
  -- meslol = 'MesloLGL Nerd Font Mono:h13.0:w-0.4',
  -- meslom = 'MesloLGM Nerd Font Mono:h13.0:w-0.4',
  meslos = 'MesloLGS Nerd Font Mono:h13.0:w-0.4',
  -- DZ = dotted zero variants
  -- meslolz = 'MesloLGLDZ Nerd Font Mono:h13.0:w-0.4',
  -- meslomz = 'MesloLGMDZ Nerd Font Mono:h13.0:w-0.4',
  -- meslosz = 'MesloLGSDZ Nerd Font Mono:h13.0:w-0.4',
  monoid = 'Monoid Nerd Font Mono:h12.0:w-0.2', -- [L]
  profontx = 'ProFont IIx Nerd Font Mono:h15.4:w-0.4',
  profont = 'ProFontWindows Nerd Font Mono:h15.4:w-0.4',
  sourcecode = 'SauceCodePro Nerd Font Mono:h14.0:w-1.0',
  shuretech = 'ShureTechMono Nerd Font Mono:h14.0:w-0.8',
  spacemono = 'SpaceMono Nerd Font Mono:h13:w-0.6',
  terminess = 'Terminess Nerd Font Mono:h14.8:w-0.8',
  victormono = 'VictorMono Nerd Font Mono:h13.0:w-0.0', -- [L]
  zedmono = 'ZedMono Nerd Font Mono:h13.0:w-0.0', -- [L]
}
M.set_font = function(font)
  local selected = fonts[font]
  if selected ~= nil then
    vim.o.guifont = selected
    return true
  end
end
function M.get_font_keys()
  local keys = {}
  for k, _ in pairs(fonts) do
    table.insert(keys, k)
  end
  return keys
end
function M.print_font_keys()
  for k, _ in pairs(fonts) do
    print(k)
  end
end

-- check version
-- vim.print(vim.g.neovide_version)
-- ── Font ────────────────────────────────────────────────────────────
-- set font/size options "Fontname,FallbackFontname:Opt1:Opt2" etc
--  options:hX/wX, b,i bold/italic, #e-[font_alias_option] #h-[full|normal|slight|none] (HINTING)
--  // ||\\ --> <-- =<< <= ~= |-> == ===
-- vim.o.guifont = ' nerd font:h13:w-0'
-- ── Transparency ────────────────────────────────────────────────────
-- vim.g.neovide_opacity = 0.0
-- vim.g.transparency = 0.8
-- local alpha = function()
--   return string.format('%x', math.floor((255 * vim.g.transparency) or 0.8))
-- end
-- vim.g.neovide_background_color = '#0f1117' .. alpha()
-- ────────────────────────────────────────────────────────────────────
-- ────── change scaling (mostly font size) ──────
-- vim.g.neovide_scale_factor = 1.0
-- vim.g.neovide_text_gamma = -0.1
-- vim.g.neovide_text_contrast = 0.3
-- vim.print(vim.g.neovide_scale_factor)

return M
