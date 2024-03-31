return {
  "petertriho/nvim-scrollbar",
  opts = {
    -- Avoid shrinking handle at end of buffer
    -- on overscrolling.
    hide_if_all_visible = true,
    handle = {
      color = "#8C83A4", -- dcolors.bg_highlight,
      blend = 0,
    },
    marks = {
      Search = { color = "#de8f76" }, -- colors.orange },
      Error = { color = "#e965a5" }, -- colors.error },
      Warn = { color = "#ddb976" }, -- colors.warning },
      Info = { color = "#e1ece4" }, -- colors.info },
      Hint = { color = "#b1baf4" }, -- colors.hint },
      Misc = { color = "#e192ef" }, -- colors.purple },
      Cursor = {
        color = "#948CAE", -- colors.bg_highlight
        text = "█",
      },
    },
  },
}
