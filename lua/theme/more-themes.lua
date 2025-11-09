return {
  -- ── Even more later 2025: ───────────────────────────────────────────
  { 'zootedb0t/citruszest.nvim', lazy = false, priority = 1000 },
  { 'ptdewey/monalisa-nvim', priority = 1000 },
  { 'uloco/bluloco.nvim', lazy = false, priority = 1000, dependencies = { 'rktjmp/lush.nvim' } }, -- LUSH
  {
    'samharju/serene.nvim',
  },
  { 'bluz71/vim-moonfly-colors', name = 'moonfly', lazy = false, priority = 1000 },
  {
    'katawful/kat.nvim', --[[ tag = 3.1 ]]
  },
  { 'roobert/palette.nvim', lazy = false, priority = 1000 },
  { 'mrjones2014/lighthaus.nvim' },
  { 'justinsgithub/oh-my-monokai.nvim', opts = { transparent_background = false, terminal_colors = true, devicons = true } },
  {
    'stevedylandev/darkmatter-nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'ricardoraposo/nightwolf.nvim', -- meh. just needs such a minor bg change
    lazy = false,
    priority = 1000,
    opts = {},
  },
  --{ 'kaiuri/nvim-juliana' }, -- no
  { 'pwntester/nautilus.nvim' }, -- might need setup, might need transparent = false
  {
    'adibhanna/forest-night.nvim',
    priority = 1000,
  },

  -- ── Even Later 2025: ────────────────────────────────────────────────
  -- { 'genmzy/deus.nvim' }, -- the only working deus lmao BUT I DONT NEED YOU NO MORE
  { 'sekke276/dark_flat.nvim' },
  { 'ptdewey/darkearth-nvim', priority = 1000 },
  { 'metalelf0/jellybeans-nvim' },
  { 'uhs-robert/oasis.nvim' },
  { 'rockerBOO/boo-colorscheme-nvim' }, -- idk
  -- this dude likes his monokai
  {
    'sainnhe/sonokai',
    config = function()
      vim.g.sonokai_style = 'atlantis'
      vim.g.sonokai_better_performance = 1
    end,
  }, -- STYLE: andromeda-atlantis (neut (w-c)), espresso (warm),
  { 'sainnhe/edge' }, -- steal (this is non-lua)
  --{ 'Abstract-IDE/Abstract-cs' }, -- steal, delete
  { 'yonlu/omni.vim' }, -- put in material
  { 'ray-x/starry.nvim', priority = 1000, opts = { disable = { background = false } } }, --  steal the good ones and remove
  { 'fenetikm/falcon' }, -- like
  --  { 'ofirgall/ofirkai.nvim', opts = { theme = 'dark_blue' } }, -- yellow monkai bg but also darkblue which is good. eh
  { 'yashguptaz/calvera-dark.nvim' },
  { 'nxvu699134/vn-night.nvim' },
  { 'adisen99/codeschool.nvim' },
  { 'titanzero/zephyrium' }, -- zephyr fork
  { 'thesimonho/kanagawa-paper.nvim', lazy = false, priority = 1000 }, -- may need opts {}
  { 'kevinm6/kurayami.nvim', priority = 1000 },
  { 'kvrohit/rasmus.nvim', priority = 1000 }, -- trying again
  { 'lmburns/kimbox' }, -- may need opts {}
  { 'qaptoR-nvim/chocolatier.nvim' },
  { 'Mofiqul/adwaita.nvim', lazy = false, priority = 1000 },
  { 'nyngwang/nvimgelion' },
  { 'scottmckendry/cyberdream.nvim', opts = { transparent = false } },
  { 'loganswartz/sunburn.nvim', dependencies = { 'loganswartz/polychrome.nvim' } }, -- needs additional plugin
  { 'ptdewey/darkearth-nvim', priority = 1000 }, -- brown af
  { 'slugbyte/lackluster.nvim', lazy = false, priority = 1000 }, -- dark, minimal, lowmid saturation
  {
    '0xstepit/flow.nvim', -- oceanic/quantumy (i do like)
    lazy = false,
    priority = 1000,
    opts = { theme = { transparent = false } },
  },
  { 'bakageddy/alduin.nvim', priority = 1000 }, -- another good brown

  { 'mcauley-penney/techbase.nvim', priority = 1000, opts = { transparent = false } }, -- not a complete theme
  -- ── Late 2025: ──────────────────────────────────────────────────────
  { 'rktjmp/lush.nvim' }, -- screw it adding lush
  { 'JLighter/aura.nvim' }, -- lush
  {
    'metalelf0/black-metal-theme-neovim',
    lazy = false,
    priority = 1000,
    config = function()
      require('black-metal').setup { transparent = false, alt_bg = true, Transparent = false }
      --vim.print(require('black-metal').options())
    end,
    enabled = false,
  },
  { 'cpea2506/one_monokai.nvim' },
  { 'datsfilipe/vesper.nvim' },
  { 'akinsho/horizon.nvim' }, -- add version = "*" if bad
  { 'pineapplegiant/spaceduck' },
  { 'diegoulloao/neofusion.nvim', priority = 1000, opts = {} }, -- actually unique
  { 'tobi-wan-kenobi/zengarden', opts = { variant = 'orange' } }, -- like
  { 'Shatur/neovim-ayu' }, --opts = { mirage = false, terminal = true, overrides = {} } },
  { 'savq/melange-nvim' },
  -- ── removed Lazy=False from: ────────────────────────────────────────
  { 'jwbaldwin/oscura.nvim', priority = 1000, opts = {} }, --(L=F) deep colors, see help/readme.md for config
  { 'olivercederborg/poimandres.nvim', priority = 1000, opts = {} }, --(L=F)dark neut/blue bg with green accents
  -- ──────────────────────────────────────────────────────────────────────
  { 'drewxs/ash.nvim', priority = 1000 },
  { 'arturgoms/moonbow.nvim' }, -- improve + add to Material d
  { 'sontungexpt/witch', priority = 1000, lazy = false }, -- spooky witch. if run setup() it messes up all theme :)
  { 'craftzdog/solarized-osaka.nvim', lazy = false, priority = 1000, opts = { transparent = false } }, -- best solarized
  { 'numToStr/Sakura.nvim' }, -- its rose pine but darker/vibranter
  { 'eddyekofo94/gruvbox-flat.nvim' }, -- idk
  -- { 'https://gitlab.com/bartekjaszczak/luma-nvim', priority = 1000, }, -- ugly as sin rn
  -- { 'https://gitlab.com/bartekjaszczak/finale-nvim', priority = 1000 }, -- also pretty fuckin ugly
  --{ url = 'https://gitlab.com/sxwpb/halfspace.nvim' }, -- not workin prob Lazy thing
  --{ 'RishabhRD/gruvy'  }, no worky
  --{ 'embark-theme/vim' }, -- it's a lighter rose pine, do not need
  -- { 'Alexis12119/nightly.nvim', priority = 1000 }, --(L=F) OPTS={} IF ERRORS -- literally just everblush but with blue vals instead of yellow
  -- { '2giosangmitom/nightfall.nvim', lazy = false, priority = 1000, opts = {} },
  -- { 'Vallen217/eidolon.nvim', priority = 1000 }, --(L=F) like rose pine but more blues/greens. maybe delete.
  --{ 'calind/selenized.nvim' },
  --{ 'kvrohit/substrata.nvim' }, -- removing, just poimandres with super low contrast
  { 'Skardyy/makurai-nvim', priority = 1000 },
  { 'yorumicolors/yorumi.nvim' },
  { 'rose-pine/neovim', name = 'rose-pine' }, -- its rose pine
  { 'ramojus/mellifluous.nvim', opts = { colorset = 'kanagawa_dragon', mellifluous = { neutral = false } } },
  { 'JoosepAlviste/palenightfall.nvim' }, -- neut to bluepurp
  { 'dgox16/oldworld.nvim', priority = 1000, lazy = false, opts = { variant = 'cooler' } },
  { 'mellow-theme/mellow.nvim' }, -- slight warm that looks good, has config opts
  {
    'ilof2/posterpole.nvim',
    priority = 1000,
    opts = { brightness = -2, fg_saturation = 10, bg_saturation = -2 },
  },
  {
    'ficcdaf/ashen.nvim',
    -- tag = '*', uncomment if issues
    lazy = false,
    priority = 1000,
    opts = {
      style_presets = { bold_functions = true },
    },
  },
  {
    'loctvl842/monokai-pro.nvim',
    opts = {
      override = function()
        return { -- seriously I had to do this shit to make the cursor usable
          Cursor = { bg = '#baaa8a', fg = '#3a301a', sp = '#8a1c2c', bold = true },
        }
      end,
    },
  },

  -- ── chopping block ──────────────────────────────────────────────────
}
