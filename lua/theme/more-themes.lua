local need_lush = {
  -- all here need:
  { 'rktjmp/lush.nvim' },
  { 'JLighter/aura.nvim' },
}

--BUG: ITS DOING THE THING
--TODO: FIND WHO PUT THE STINKY BIT IN ────────────────────────────────

--NOTE: IF ANY OF THESE ARE HAVING ISSUES:
-- ADD LAZY=FALSE IF LAZY=FALSE IS COMMENTED OR IN COMMENT
-- TRY ADDING OPTS = {}
return {
  -- ── removed Lazy=False from: ────────────────────────────────────────
  { 'forest-nvim/sequoia.nvim', priority = 1000 },
  { 'Alexis12119/nightly.nvim', priority = 1000 }, --(L=F) OPTS={} IF ERRORS -- reminiscent of everblush
  { 'jwbaldwin/oscura.nvim', priority = 1000, opts = {} }, --(L=F) deep colors, see help/readme.md for config
  { 'drewxs/ash.nvim', priority = 1000 }, --(L=F) oooh
  { 'Vallen217/eidolon.nvim', priority = 1000 }, --(L=F) dark blue-purp bg with greens; good
  { 'olivercederborg/poimandres.nvim', priority = 1000, opts = {} }, --(L=F)dark neut/blue bg with green accents
  -- ──────────────────────────────────────────────────────────────────────
  --{ 'oonamo/ef-themes.nvim' }, -- pack. warm purpley
  { 'sontungexpt/witch', priority = 1000, lazy = false }, -- spooky witch. if run setup() it messes up all theme :)
  { 'craftzdog/solarized-osaka.nvim', lazy = false, priority = 1000, opts = { transparent = false } }, -- best solarized
  { 'numToStr/Sakura.nvim' }, -- total gamble. Like; no readme, no pics, nothin
  {
    '2giosangmitom/nightfall.nvim', -- IF HAVING ISSUES GO CHECK REPO FOR THE ACTUL SETUP
    lazy = false,
    priority = 1000,
    opts = {}, -- Add custom configuration here
  },
  { 'Skardyy/makurai-nvim', opts = { transparent = false } }, -- theme pack; nerd theme names
  { 'calind/selenized.nvim' }, -- MORE SOLARIZED!
  { 'talha-akram/noctis.nvim' }, -- pack. TOO many solarizey themes
  { 'yorumicolors/yorumi.nvim' }, -- dark is fine. I'm weirdly into the light theme
  { 'ronisbr/nano-theme.nvim' }, -- Very minimal. add vim.o.background = 'dark' if this errors
  { 'kvrohit/substrata.nvim' }, -- very minimal
  { 'arturgoms/moonbow.nvim' }, -- Horribly vibrant gruvbox with a bit of sea color
  { 'rose-pine/neovim', name = 'rose-pine' }, -- its rose pine
  { 'Allianaab2m/penumbra.nvim' }, -- neutral bg pastel-ish colors
  { 'ilof2/posterpole.nvim', priority = 1000, config = true }, -- its warm and purple. has adaptive brightness if want
  { 'dgox16/oldworld.nvim', priority = 1000 }, --(LAZY=FALSE) pastelly
  { -- Thought I already installed and then removed this one so we will see
    'ramojus/mellifluous.nvim',
    -- NOTE:Optional {config = true/opts = {}/setup func};
  },
  { 'kvrohit/rasmus.nvim', priority = 1000 }, -- slight warm
  { 'mellow-theme/mellow.nvim' }, -- slight warm that looks good, has config opts
  { 'JoosepAlviste/palenightfall.nvim' }, -- neut to bluepurp
  { 'bettervim/yugen.nvim' }, -- pure-black bg minimal
  { 'Yagua/nebulous.nvim' }, -- pack, solarey
  {
    'cdmill/neomodern.nvim', -- pack, warm varied themes
    lazy = false,
    priority = 1000,
    opts = {},
    -- put this back if fails/errors:
    --[[ config = function() require('neomodern').setup {} require('neomodern').load() end, ]]
  },
  {
    'ficcdaf/ashen.nvim', -- dark redder gruvvy
    -- tag = '*', uncomment if issues
    lazy = false,
    priority = 1000,
    opts = {},
  },
  -- uncomment next line if you wanna go from having way too many themes to having way way WAYY too many themes
  --{ 'neko-night/nvim', lazy = false, priority = 1000, opts = {}, },
}
