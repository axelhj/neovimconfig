return {
  "hardhackerlabs/theme-vim",
  name = "hardhacker",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.hardhacker_hide_tilde = 1
    vim.g.hardhacker_keyword_italic = 1
    -- custom highlights
    vim.g.hardhacker_custom_highlights = {}
    vim.cmd("colorscheme hardhacker")
    vim.cmd[[
      syntax      enable
      syntax      on
      set         t_Co=256
      colorscheme hardhacker
    ]]
  end,
}
