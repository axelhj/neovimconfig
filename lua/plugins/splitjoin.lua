return {
  "Wansmer/treesj",
  event = { "VeryLazy" },
  keys = {
    { "gs", function() require"treesj".split() end },
    { "gj", function() require"treesj".join() end },
  },
  opts = {
    use_default_keymaps = false,
    max_join_length = 350
  },
}
