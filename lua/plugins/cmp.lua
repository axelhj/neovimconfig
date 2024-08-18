return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "rafamadriz/friendly-snippets",
    -- "L3MON4D3/LuaSnip",
    -- "saadparwaiz1/cmp_luasnip",
  },
  keys = {
    {
      "<C-n>",
      mode = "n",
      desc = "Show next completion [C-n]"
    }, {
      "<C-Space>",
      mode = "n",
      desc = "Show completions [C-Space]"
    }, {
      "<C-p>",
      mode = "n",
      desc = "Show previous completion [C-p]"
    },
  },
  config = function()
    local cmp = require "cmp"
    --    local luasnip = require "luasnip"
    --    require("luasnip.loaders.from_vscode").lazy_load()
    --    luasnip.config.setup {}
    cmp.setup {
      -- snippet = {
      --   expand = function(args)
      --     luasnip.lsp_expand(args.body)
      --   end,
      -- },
      completion = {
        completeopt = 'menu,menuone,noinsert,noselect',
        autocomplete = {
          cmp.TriggerEvent.TextChanged,
          cmp.TriggerEvent.InsertEnter,
        },
        keyword_length = 0,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["Esc"] = cmp.mapping.abort(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-b>"] = cmp.mapping.scroll_docs(-8),
        ["<C-f>"] = cmp.mapping.scroll_docs(8),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<Tab>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        -- { name = "luasnip" },
      },
    }
  end
}
