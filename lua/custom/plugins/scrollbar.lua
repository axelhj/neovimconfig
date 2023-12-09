return {
  "petertriho/nvim-scrollbar",
  config = function()
    require"scrollbar".setup({
      handle = {
        color = "#938aad" -- dcolors.bg_highlight,
      },
      marks = {
        Search = { color = "#de8f76" }, -- colors.orange },
        Error = { color = "#e965a5" }, -- colors.error },
        Warn = { color = "#ddb976" }, -- colors.warning },
        Info = { color = "#e1ece4" }, -- colors.info },
        Hint = { color = "#b1baf4" }, -- colors.hint },
        Misc = { color = "#e192ef" }, -- colors.purple },
    }})
  end,
}
