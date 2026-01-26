local augroup = vim.api.nvim_create_augroup("nvim-treesitter", { clear = true })
local enabled_parsers = {
  "c",
  "cpp",
  "lua",
  "python",
  "scala",
  "tsx",
  "javascript",
  "typescript",
  "c_sharp",
  "vimdoc",
  "vim",
  "lua",
  "go",
  "rust",
}
local supported_filetypes = {
  "c",
  "cpp",
  "lua",
  "python",
  "scala",
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "cs",
  "vimdoc",
  "vim",
  "lua",
  "go",
  "rust",
}

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    nvim_treesitter = require("nvim-treesitter")
    nvim_treesitter.install(enabled_parsers)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = supported_filetypes,
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require\"nvim-treesitter\".indentexpr()"
      end,
      group = augroup
    })
  end,
}
