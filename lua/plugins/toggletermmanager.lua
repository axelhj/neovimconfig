return {
  "ryanmsnyder/toggleterm-manager.nvim",
  dependencies = {
    "akinsho/toggleterm.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- only needed because it"s a dependency of telescope
  },
  opts = {
    mappings = {
      i = {
        ["<Cr>"] = {
          action = function(prompt_bufnr)
            require("toggleterm-manager").actions.toggle_term(prompt_bufnr, false)
            require"semiplugins.feedkeys".replace_termcodes_async("<C-\\><C-n>i")
          end,
        },
        ["<S-Cr>"] = {
          action = function(prompt_bufnr)
            require("toggleterm-manager").actions.toggle_term(prompt_bufnr, true)
            require"semiplugins.feedkeys".replace_termcodes_async("<C-\\><C-n><Esc>")
          end,
        },
        ["<C-i>"] = {
          action = function(prompt_bufnr)
            require("toggleterm-manager").actions.create_term(prompt_bufnr, false)
            require"semiplugins.feedkeys".replace_termcodes_async("<C-\\><C-n>")
          end,
        },
        ["<C-d>"] = {
          action = function(prompt_bufnr)
            require("toggleterm-manager").actions.delete_term(prompt_bufnr, false)
          end,
        },
        ["<C-r>"] = {
          action = function(prompt_bufnr)
            require("toggleterm-manager").actions.rename_term(prompt_bufnr, false)
          end,
        },
      },
    },
  },
  keys = {
    {
      "<Leader>ft",
      function() require("toggleterm-manager").open({}) end,
      mode = "n",
      desc = "Toggle the toggleterm-manager [<Leader>ft] (telescope).",
    },
  },
}
