return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
  config = function()
    vim.api.nvim_set_hl(0, "IndentGuideBgAlt1", {
      bg = "#282433", -- Match Normal-bg
      fg = "#303030", -- Regular fg
    })
    vim.api.nvim_set_hl(0, "IndentGuideBgAlt2", {
      bg = "#24202e", -- Slightly darker Normal-bg
      fg = "#303030", -- Alternate fg
    })
    local highlight = {
      "IndentGuideBgAlt1",
      "IndentGuideBgAlt2",
    }
    require("ibl").setup({
      scope = {
        enabled = false,
      },
      indent = {
        highlight = highlight,
        char = " ",
      },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
    })
  end
}
