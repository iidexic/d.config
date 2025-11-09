vim = vim
local M = {}

M.neovide_config = function()
  -- check version
  vim.print(vim.g.neovide_version)

  -- ── Font ────────────────────────────────────────────────────────────
  -- set font/size options "Fontname,FallbackFontname:Opt1:Opt2" etc
  --  options:hX/wX, b,i bold/italic, #e-[font_alias_option] #h-[full|normal|slight|none] (HINTING)
  --  // ||\\ --> <-- =<< <= ~= |-> == ===
  -- vim.o.guifont = ' nerd font:h13:w-0'
  -- ── NEW FONTS ───────────────────────────────────────────────────────
  vim.o.guifont = 'sono nerd font:h14.0:w-2.4'
  vim.o.guifont = 'Block mono nerd font:h12.0:w-1.0'
  vim.o.guifont = 'demmomono400 nerd font:h18.0:w-3.8'
  vim.o.guifont = 'featuremono nerd font:h15.0:w-0.6' -- [L]
  vim.o.guifont = 'sudo nerd font:h16.0:w-0.6' -- [L]
  vim.o.guifont = 'crystald nerd font:h15.6:w-0.8'
  vim.o.guifont = 'monofokisquish nerd font:h15.4:w-0.6'
  -- ──────────────────────────────────────────────────────────────────────

  --  Iosevkas
  vim.o.guifont = 'Iosvmata:h14.6:w-1.0'
  vim.o.guifont = 'Pragmasevka nerd font:h14.6:w-0.3'
  vim.o.guifont = 'zedmono nerd font:h13.0:w-0.0' -- [L]
  vim.o.guifont = 'iosevkacomfyd nerd font:h14.6:w-1.0'
  vim.o.guifont = 'iosevkaMT nerd font:h14.0:w-0.6'
  vim.o.guifont = 'nova nerd font:h13.0:w-1.4'
  -- vim.o.guifont = 'iosevkadtype nerd font:h13:w-0.3' -- BRING BACK WEN I FIX THE FONT

  -- Iosevkalikes
  vim.o.guifont = 'inputmonocompressed nerd font:h14.6:w-1.0'
  vim.o.guifont = 'JetBrainsMono Nerd Font:h12.4:w-0.8' -- [L]
  vim.o.guifont = 'zenbonesbrainy nerd font:h13.0:w-0.4' -- [L]
  vim.o.guifont = 'zenbonesproto nerd font:h13.0:w-0.6' -- [L]

  -- Besties
  vim.o.guifont = 'brassmonocode nerd font:h15.8:w-1.6' -- [L]
  vim.o.guifont = 'monoidtight nerd font:h11.6:w0.2' -- [L]
  vim.o.guifont = 'ankacoder nerd font:h15.0:w-0.4'
  vim.o.guifont = 'BinchotanSharpD Nerd Font:h15:w-1.4'
  vim.o.guifont = 'envycodeR Nerd Font:h14:w-0.6:#e-subpixelantialias'
  vim.o.guifont = 'dpsdbeyond nerd font:h15:w-1.0'
  vim.o.guifont = 'M+1code nerd font:h13.3:w-0'
  vim.o.guifont = 'monoOne nerd font:h13.6:w-1.0'
  vim.o.guifont = 'shuretechmono Nerd Font:h14.5:w-1.2'
  vim.o.guifont = 'monkey nerd font:h18.4:w0.8'
  vim.o.guifont = 'nk57dmono nerd font:h14.5:w-0.3'

  -- second-besties
  vim.o.guifont = 'lekton nerd font:h16.4:w-1.8'
  vim.o.guifont = 'recmonoduotone nerd font:h13.6:w-1.4' -- [L] (also casual ligatures)
  vim.o.guifont = 'fn0t nerd font:h21:w-0.2'
  vim.o.guifont = 'nkduymono nerd font:h12.3:w-0.8' -- [L]
  vim.o.guifont = 'agave nerd font:h15:w-1.4'
  vim.o.guifont = 'martianmonoct nerd font:h13.4:w-1.0' -- [L]
  vim.o.guifont = 'maple mono nf:h13:w-0.4' -- [L]
  vim.o.guifont = 'DaddyTimeMono nerd font:h12.7:w-1.0'

  -- chunky
  vim.o.guifont = 'kodemonodnf:h15.0:w-0.8' -- [L]
  vim.o.guifont = 'kodemono nerd font:h12.5:w-1.0' -- [L]
  vim.o.guifont = 'barecast nerd font:h14.0:w-2.6'
  vim.o.guifont = 'gothamonov0.2 nerd font:h13.6:w-0.0'
  vim.o.guifont = 'skyhookmono nerd font:h14:w-2.0'
  vim.o.guifont = 'Terminess Nerd Font:h15.0:w-1.2'
  vim.o.guifont = 'Spleen32x64 nerd font:h15.0:w-1.0'
  vim.o.guifont = 'greybeard22 nerd font:h16.4:w-1.0'

  -- wideboys
  vim.o.guifont = 'Anonymous pro:h16.4:w-0.6'
  vim.o.guifont = 'hack nerd font:h14:w-2'
  vim.o.guifont = 'hurmit Nerd Font:h12.0:w-1.0'
  vim.o.guifont = 'geistmono nerd font:h14:w-0.8'
  vim.o.guifont = 'recmonolinear nerd font:h13.6:w-2.0' -- [L]
  vim.o.guifont = '0xproto v2 ligaturised nf:h13.4:w-2.0'
  vim.o.guifont = 'overpassmtnf:h14.4:w-2.0'
  vim.o.guifont = 'antikormono nerd font:h12.6:w-1.8'
  vim.o.guifont = 'commitmono nerd font:h15:w-1.8'

  -- fineboys
  vim.o.guifont = 'ttinterphasespromonotrl nerd font:h13:w-1.6'
  vim.o.guifont = 'apl385unicode nerd font:h14.2:w-2.4'
  vim.o.guifont = 'luculent nerd font:h13:w-0.8'
  vim.o.guifont = 'agyxmono nerd font:h13.0:w-1.0'
  vim.o.guifont = 'lilex nerd font:h12.6:w-1.2'
  vim.o.guifont = 'blexmono nerd font:h12.6:w-1.4'
  vim.o.guifont = 'd2codingligature Nerd Font:h14:w-1.0' -- [L]
  vim.o.guifont = 'cousine nerd font:h14.4:w-2'
  vim.o.guifont = 'fragmentmono nerd font:h13:w-1.0'

  -- custom newest september
  vim.o.guifont = 'Lotion nerd font:h11.6:w-0.2'
  vim.o.guifont = 'nfcode nerd font:h12:w-0.6' -- fix the m and w in fontforge

  -- custom ok
  vim.o.guifont = 'ramono nerd font:h13:w-1.4'

  -- custom, meh
  vim.o.guifont = 'indicatemono Nerd Font:h14:w-2.0'
  vim.o.guifont = 'iosevkamayukaioriginal nerd font:h14:w-0.2'
  vim.o.guifont = 'ltbinaryneue nerd font:h13.6:w-1.0'
  vim.o.guifont = 'telegramarenderosn nerd font:h11:w-1.0'
  vim.o.guifont = 'fairfaxhaxhd nerd font:h16:w-1.4'
  vim.o.guifont = 'flexiibmvgatrue nerd font:h16:w-0.0'
  vim.o.guifont = 'nk57monospacecdrg nerd font:h13.6:w-0.3'
  vim.o.guifont = 'leaguemono nerd font:h14:w-0.2'
  --
  -- Tier 2
  vim.o.guifont = 'spacemono Nerd Font:h13.8:w-1.6' -- change line height
  vim.o.guifont = 'monaspicekr Nerd Font:h13.3:w-2.0'
  vim.o.guifont = 'victormono nerd font:h13:w-0'
  vim.o.guifont = 'profontwindows nerd font:h15.4:w-0.4'
  vim.o.guifont = 'M+Codelat50 nerd font propo:h14:w-0:#e-subpixelantialias'
  vim.o.guifont = '3270 nerd font:h16.3:w-0.0'
  vim.o.guifont = 'audiolinkmono nerd font:h14.8:w-1'
  vim.o.guifont = 'adwaitamono Nerd Font:h13:w-1.0'

  -- pixel fonts
  vim.o.guifont = 'envycodeb10pt nerd font:h14.0:w-1.0:#e-subpixelantialias'
  vim.o.guifont = 'monocraft_Nerd_Font:h13:w-0.8'
  vim.o.guifont = 'GohuFont 14 nerd font:h14:w-1.4'
  vim.o.guifont = 'GohuFont 11 nerd font:h14:w-0.4'
  vim.o.guifont = 'DepartureMono nerd font:h13:w-1.0'
  vim.o.guifont = 'bigbluetermplus nerd font:h13:w-1.4'
  vim.o.guifont = 'bigblueterm437 nerd font:h13:w-1.4'
  vim.o.guifont = 'ProggyClean nerd font:h18:w-0.0'

  -- Other/Extra
  vim.o.guifont = 'Iosevka nerd font:h13:w-0.0'
  vim.o.guifont = 'inconsolataGo nerd font:h15:w-0.2'
  vim.o.guifont = 'meslolgs nf:h13:w-0.4'
  vim.o.guifont = 'monaspicene Nerd Font:h13:w-1.2'
  vim.o.guifont = 'mononoki nerd font:h14:w-1.2'
  vim.o.guifont = 'eirian nerd font:h16.4:w-0.0'
  vim.o.guifont = 'atkynsonmono nerd font:h14:w-2.0'
  vim.o.guifont = 'saucecodepro Nerd Font:h14:w-1.4'
  vim.o.guifont = 'monoid nerd font:h12.0:w-1.2' -- [L]
  vim.o.guifont = 'overpassm Nerd Font:h13:w-1.4'
  vim.o.guifont = 'crystal nerd font:h13:w-1.0'
  vim.o.guifont = 'martianmonocond nerd font:h13.4:w-1.0'

  -- ── Transparency ────────────────────────────────────────────────────
  vim.g.neovide_opacity = 0.0
  vim.g.transparency = 0.8
  local alpha = function()
    return string.format('%x', math.floor((255 * vim.g.transparency) or 0.8))
  end
  vim.g.neovide_background_color = '#0f1117' .. alpha()
  -- ────────────────────────────────────────────────────────────────────
  -- change scaling (mostly font size)
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_text_gamma = -0.1
  vim.g.neovide_text_contrast = 0.3
  vim.print(vim.g.neovide_scale_factor)
end

return M
