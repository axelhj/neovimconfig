vim.g.skip_ts_context_commentstring_module = true

return {
  -- "gc" or "Ctrl+," or "Alt+," to comment visual regions/lines
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
      desc = "Toggle line comment with Comment.nvim (motion)"
    },
    {
      "gb",
      mode = "n",
      desc = "Toggle block comment with Comment.nvim (motions)"
    },
    {
      "gc",
      mode = "v",
      desc = "Toggle line comment with Comment.nvim (visual)"
    },
    {
      "<C-,>",
      "gc",
      mode = "v",
      desc = "Toggle line comment with Comment.nvim (visual)"
    },
    {
      "<M-,>",
      "gc",
      mode = "v",
      desc = "Toggle line comment with Comment.nvim (visual)"
    },
    -- Must be commented to not be interpreted as
    -- gc (comment toggle) followed by c<waiting for motion>
    --[[ {
      "gcc",
      mode = "n",
      desc = "Toggle line comment with Comment.nvim"
    }, ]]
    {
      "<C-,>",
      "gcc",
      mode = "n",
      desc = "Toggle line comment with Comment.nvim"
    },
    {
      "<M-,>",
      "gcc",
      mode = "n",
      desc = "Toggle line comment with Comment.nvim"
    },
    {
      "gbc",
      mode = "n",
      desc = "Toggle block comment for line with Comment.nvim"
    },
  },
}
