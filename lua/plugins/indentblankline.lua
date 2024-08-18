local highlights = {
  "IndentGuideBgAlt1",
  "IndentGuideBgAlt2",
}

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  module = "ibl",
  event = { "VeryLazy" },
  config = function() end,
  opts = {
    scope = {
      enabled = false,
    },
    indent = {
      highlight = highlights,
      char = "•",
    },
    whitespace = {
      highlight = highlights,
      remove_blankline_trail = false,
    },
  },
}
