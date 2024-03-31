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
        line = "<C-,>",
      },
      pre_hook =
        require("ts_context_commentstring.integrations.comment_nvim")
          .create_pre_hook(),
    }
  end,
  keys = {
    {
      "<C-,>",
      "gc",
      mode = "n",
      desc = "Toggle comment with Comment.nvim"
    },
    {
      "gcc",
      mode = "n",
      desc = "Toggle comment with Comment.nvim"
    },
    {
      "gc",
      mode = "v",
      desc = "Toggle comment with Comment.nvim (visual)"
    },
    {
      "gc",
      mode = "n",
      desc = "Toggle comment with Comment.nvim (motions)"
    },
    {
      "gbc",
      mode = "n",
      desc = "Toggle block comment with Comment.nvim (motions)"
    },
    {
      "gb",
      mode = "n",
      desc = "Toggle block comment with Comment.nvim (motions)"
    },
  },
}
