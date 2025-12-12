return {
  "tpope/vim-dadbod",
  lazy = true,
  cmd = {
    "DB",
  },
  config = function()
    vim.cmd[[
      let g:db_ui_disable_info_notifications = 1
    ]]
  end,
}
