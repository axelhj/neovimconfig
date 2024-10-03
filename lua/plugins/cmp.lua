return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "rafamadriz/friendly-snippets",
  },
  event = { "InsertEnter", "CmdlineEnter" },
  keys = {
    {
      "<C-n>",
      mode = "i",
      desc = "Show next completion [C-n]"
    }, {
      "<C-p>",
      mode = "i",
      desc = "Show previous completion [C-p]"
    },
  },
  config = function()
    local cmp = require "cmp"
    cmp.setup {
      completion = {
        completeopt = "",
        autocomplete = {},
        keyword_length = 0,
      },
      -- C-n, C-p cannot be mapped; complete-mapping function
      -- appears to be blocked when mapping is overridden.
      mapping = cmp.mapping.preset.insert({
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Esc>"] = cmp.mapping.abort(),
        ["<C-u>"] = cmp.mapping.select_prev_item({ count = 4 }),
        ["<C-d>"] = cmp.mapping.select_next_item({ count = 4 }),
        ["<C-b>"] = cmp.mapping.select_prev_item({ count = 8 }),
        ["<C-f>"] = cmp.mapping.select_next_item({ count = 8 }),
        ["<Tab>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
      },
    }
  end
}
