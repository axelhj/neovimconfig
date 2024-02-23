return {
  "stevearc/conform.nvim",
  opts = {
    -- Map of filetype to formatters
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      go = { "goimports", "gofmt" },
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      ['typescript.jsx'] = { { "prettierd", "prettier" } },
    },
    format_on_save = {
      -- I recommend these options. See :help conform.format for details.
      lsp_fallback = false,
      timeout_ms = 10000
    },
  }
}
