local function map_toggleterm()
  function _G.ttmap()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  end
  -- if you only want these mappings for toggle term use term://*toggleterm#* instead
  vim.cmd 'autocmd! TermOpen term://* lua ttmap()'
end
local function cmd(s)
  return '<cmd>' .. s .. '<CR>'
end
local function dsc(s)
  return { desc = s }
end

local maptables = {
  -- Trying whichkey-style above
  go = {
    { '<leader>gr', cmd 'GoRun', dsc 'Go Run' },
    { '<leader>gd', cmd 'GoDoc', dsc 'GoDoc lookup' },
    { '<leader>ga', cmd 'GoAlt', dsc 'GoAlt toggle to tests' },
    { '<leader>gf', cmd 'GoRun -F', dsc 'Go Run Floating window' },
    { '<leader>gb', cmd 'GoBuild', dsc 'Go Build to cwd' },
    { '<leader>gt', cmd 'GoTest -n', dsc 'Go Test selected' },
  },
  other = {},
}
local function mapFromTable(mtable)
  for _, value in pairs(mtable) do
    for _, m in ipairs(value) do
      if #m <= 3 then
        vim.keymap.set('n', m[1], m[2], m[3])
      elseif #m == 4 then
        vim.keymap.set(m[1], m[2], m[3], m[4])
      end
    end
  end
end
--[[
Example of using which-key to generate maps
which-key docs state that wk.add should be used
so I replaced wk.register with wk.add here.
no guarantees at all that it actually works

EDIT: this does not work, so fuck you I'll do it myself
--wk.add({
      ["<Leader>"] = {
        c = {
          name = " □  Boxes",
          b = { "<Cmd>CBccbox<CR>", "Box Title" },
          t = { "<Cmd>CBllline<CR>", "Titled Line" },
          l = { "<Cmd>CBline<CR>", "Simple Line" },
          m = { "<Cmd>CBllbox14<CR>", "Marked" },
          -- d = { "<Cmd>CBd<CR>", "Remove a box" },
        },
      },
    })
--
--
--]]
local function makenested()
  local keynest = require 'settings.nested-map'
  local nkGo = { key_leader = { g = {
    { 'r', '{c}' },
  } } }
end
local Map = {
  assign = function()
    vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') --  See `:help hlsearch`
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
    vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
    vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
    vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

    map_toggleterm()
    mapFromTable(maptables)
  end,
  wkMapNested = function(nestedmap)
    local wk = require 'which-key'
    for k, val in pairs(nestedmap) do
    end
  end,
}
return Map
