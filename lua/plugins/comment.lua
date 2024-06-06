vim.g.skip_ts_context_commentstring_module = true

return {
  -- "gc" or "Ctrl+," to comment visual regions/lines
  "numToStr/Comment.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  lazy = true,
  config = function()
    require("ts_context_commentstring").setup {
      enable_autocmd = false,
    }
    require("Comment").setup {
      toggler = {
        line = "gc",
      },
      pre_hook =
        require("ts_context_commentstring.integrations.comment_nvim")
          .create_pre_hook(),
    }
  end,
  keys = {
    {
      "gc",
      mode = "n",
      desc = "Toggle comment (line) with Comment.nvim (motion)"
    },
    {
      "gc",
      mode = "v",
      desc = "Toggle comment (line) with Comment.nvim (visual)"
    },
    {
      "<C-,>",
      "gc",
      mode = "v",
      desc = "Toggle comment (line) with Comment.nvim (visual)"
    },
    {
      "<M-,>",
      "gc",
      mode = "v",
      desc = "Toggle comment (line) with Comment.nvim (visual)"
    },
    {
      "<C-,>",
      "gcc",
      mode = "n",
      desc = "Toggle comment (line) with Comment.nvim"
    },
    {
      "<M-,>",
      "gcc",
      mode = "n",
      desc = "Toggle comment (line) with Comment.nvim"
    },
    {
      "gc",
      mode = "n",
      desc = "Toggle comment with Comment.nvim (motions)"
    },
    {
      "gbc",
      mode = "n",
      desc = "Toggle block comment with Comment.nvim"
    },
    {
      "gb",
      mode = "n",
      desc = "Toggle block comment with Comment.nvim (motions)"
    },
  },
}
