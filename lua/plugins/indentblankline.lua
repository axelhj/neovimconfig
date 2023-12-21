return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  config = function()
    vim.api.nvim_set_hl(0, "IndentGuideBg", {
      bg = "#24202e",
      fg = "#221e2b",
    })
    local highlight = {
      "Normal",
      "IndentGuideBg",
    }
    require("ibl").setup({
      scope = {
        enabled = false,
      },
      indent = {
        highlight = highlight,
        char = "",
      },
      whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
      },
    })
  end
}
