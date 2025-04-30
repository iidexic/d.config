return {
  {
    'francescarpi/buffon.nvim',
    ---@type BuffonConfig
    opts = {
      --- Add your config here
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-lua/plenary.nvim',
    },
  },
}
--[[ Defaults and Mappings:
{
  cyclic_navigation = true,
  --- possible values:
  ---   "start": buffers are added at the begginning of the buffers list
  ---   "end": buffers are added at the end of the list
  ---   "after": are added after the active buffer
  new_buffer_position = "end",
  num_pages = 2,
  open = {
    by_default = true,
    ignore_ft = {
      "gitcommit",
      "gitrebase",
    },
  },
  theme = {
    unloaded_buffer = "#404040",
    shortcut = "#CC7832",
    active = "#51afef",
    unsaved_indicator = "#f70067",
  },
  leader_key = ";",
  mapping_chars = "qweryuiop",
  keybindings = {
    goto_next_buffer = "<s-j>",
    goto_previous_buffer = "<s-k>", --!NOTE: May clash with nvim_lspconfig shift-k bind. Move it elsewhere if so
    move_buffer_up = "<s-l>",
    move_buffer_down = "<s-h>",
    move_buffer_top = "<s-t>",
    move_buffer_bottom = "<s-b>",
    toggle_buffon_window = "<buffonleader>n",
    --- Toggle window position allows moving the main window position
    --- between top-right and bottom-right positions
    toggle_buffon_window_position = "<buffonleader>nn",
    switch_previous_used_buffer = "<buffonleader><buffonleader>",
    close_buffer = "<buffonleader>d",
    close_buffers_above = "<buffonleader>v",
    close_buffers_below = "<buffonleader>b",
    close_all_buffers = "<buffonleader>cc",
    close_others = "<buffonleader>cd",
    reopen_recent_closed_buffer = "<buffonleader>t",
    show_help = "<buffonleader>h",
    previous_page = "<buffonleader>z",
    next_page = "<buffonleader>x",
    move_to_previous_page = "<buffonleader>a",
    move_to_next_page = "<buffonleader>s",
  },
}
--]]
