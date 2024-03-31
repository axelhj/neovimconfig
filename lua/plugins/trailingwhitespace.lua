return {
  "johnfrankmorgan/whitespace.nvim",
  config = function()
    vim.api.nvim_set_hl(0, "IndentGuideWs", {
      bg="#221e2b",
    })
    require("whitespace-nvim").setup({
      highlight = "IndentGuideWs",
    })
  end,
}

