return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
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
        -- "go",
        -- "rust",
      },
      ts_context_commentstring = {
        enable = true,
        enable_autocmd = true,
      },
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    }
  end
}
