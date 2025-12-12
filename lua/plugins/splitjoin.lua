return {
  "AndrewRadev/splitjoin.vim",
  event = { "VeryLazy" },
  keys = {
    { "gs", ":SplitjoinSplit<cr>", mode = "n" },
    { "gj", ":SplitjoinJoin<cr>", mode = "n" },
  },
  config = function()
    vim.cmd[[
      let g:splitjoin_split_mapping = ''
      let g:splitjoin_join_mapping = ''
      let g:splitjoin_quiet = 1
      let g:splitjoin_mapping_fallback = 0
    ]]
  end,
}

-- return {
--   "Wansmer/treesj",
--   event = { "VeryLazy" },
--   keys = {
--     { "gs", function() require"treesj".split() end },
--     { "gj", function() require"treesj".join() end },
--   },
--   opts = {
--     use_default_keymaps = false,
--     max_join_length = 350,
--   },
-- }
