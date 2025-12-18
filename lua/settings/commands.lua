local M = {}

local applied = vim.o.guifont

local function argnumber(str)
  return tonumber(str:sub(3, str:len()))
end

--- Add a number to the width of the current font
--- @param mult number
--- @return string
local function fontwidth_add(mult)
  applied = vim.o.guifont
  local iwidth = applied:find ':w'

  local currwidth = tonumber(applied:sub(iwidth + 2, iwidth + 5))
  if currwidth and type(currwidth) == 'number' then
    currwidth = currwidth + (0.2 * mult)
  end
  local applyval = applied:sub(1, iwidth + 1) .. currwidth
  return applyval
end

local function fontsize_add(mult)
  return vim.g.neovide_scale_factor + (0.04 * mult)
end

M.make_commands = function()
  if vim.g.neovide then
    vim.api.nvim_create_user_command('Font', function(arg)
      local vide = require 'settings.neovide_config'
      local width = string.sub(arg.args, 1, 1) == 'w'
      local size = string.sub(arg.args, 1, 1) == 's'
      local pos = string.sub(arg.args, 2, 2) == '+'
      local neg = string.sub(arg.args, 2, 2) == '-'
      local any_mod = width or size or pos or neg
      local argnum = argnumber(arg.args)
      local arglength = arg.args:len()
      --debug
      -- vim.print(
      --
      --   'wid = '
      --     .. tostring(width)
      --     .. ' size = '
      --     .. tostring(size)
      --     .. ' pos = '
      --     .. tostring(pos)
      --     .. ' neg = '
      --     .. tostring(neg)
      --     .. '\n  argnum = '
      --     .. tostring(argnum)
      --     .. ' arg length = '
      --     .. tostring(arg.args:len())
      --     .. ' arg type = '
      --     .. type(arg.args)
      -- )
      if arg.args:len() == 2 then
        argnum = 1
      end

      if argnum and arglength < 6 and any_mod then
        if width and pos then
          vim.o.guifont = fontwidth_add(argnum)
        elseif width and neg then
          vim.o.guifont = fontwidth_add(-argnum)
        elseif size and pos then
          vim.g.neovide_scale_factor = fontsize_add(argnum)
        elseif size and neg then
          vim.g.neovide_scale_factor = fontsize_add(-argnum)
        end
      elseif arg.args == 'list' then
        vim.print(vide.print_font_keys())
      else
        vide.set_font(arg.args)
        applied = vim.o.guifont
      end
    end, { nargs = 1, complete = require('settings.neovide_config').get_font_keys })
  end
end

-- ── TEST AREA ───────────────────────────────────────────────────────
-- ──────────────────────────────────────────────────────────────────────

return M
