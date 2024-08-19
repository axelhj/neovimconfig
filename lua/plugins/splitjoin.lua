return {
  "Wansmer/treesj",
  event = { "VeryLazy" },
  keys = {
    { "gS", function() require"treesj".split() end },
    { "gJ", function() require"treesj".join() end },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 350
  },
}
