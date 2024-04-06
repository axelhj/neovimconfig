return {
  "axelhj/theme-vim",
  name = "hardhacker",
  event = { "UIEnter" },
  config = function()
    -- Colors does not get applied if loaded after hardhacker
    vim.cmd[[
      " mask tilde and use italics
      let g:hardhacker_hide_tilde = 1
      let g:hardhacker_keyword_italic = 1
      " skip monochrome bufferline theme colors
      let g:skip_bufferline_theme = 0
      " custom highlights
      let g:hardhacker_custom_highlights = []
      " enable plugin
      syntax      enable
      syntax      on
      set         t_Co=256
      colorscheme hardhacker
    ]]
    require"hardhacker"
  end,
  custom_set_highlights = function()
    -- Customize indent guide colors.
    vim.api.nvim_set_hl(0, "IndentGuideBgAlt1", {
      bg = "#282433", -- Match Normal-bg
      fg = "#303030", -- Regular fg
    })
    vim.api.nvim_set_hl(0, "IndentGuideBgAlt2", {
      bg = "#24202e", -- Slightly darker Normal-bg
      fg = "#303030", -- Alternate fg
    })
    -- Used by listchars + list
    vim.api.nvim_set_hl(0, "NonText", {
      fg = "#404040",
    })
    vim.api.nvim_set_hl(0, "SpecialText", {
      fg = "#404040",
    })
  end,
}
