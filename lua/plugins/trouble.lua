return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<Leader>dt",
      "<Cmd>lua require(\"trouble\").toggle("..
        "{mode = \"diagnostics\""..
        "{position = \"right\"})<Cr>",
      mode = "n",
      desc = "Toggle trouble diagnotstics [ dt]",
    },
  },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    position = "right",
  },
}

