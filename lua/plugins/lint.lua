return {
  "mfussenegger/nvim-lint",
  ft = {
    "markdown",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      markdown = { "vale" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      ["typescript.tsx"] = { "eslint_d" },
    }
    vim.api.nvim_create_autocmd(
      {
        "BufWritePost",
        "InsertLeave",
        "TextChanged",
      },
      { callback = function() lint.try_lint() end, }
    )
  end
}
