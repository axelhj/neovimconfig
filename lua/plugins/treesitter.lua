return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  build = ":TSUpdate",
  event = { "VeryLazy", },
  init = function(plugin)
    -- LazyVim has the following fix from Folke:
    -- https://github.com/LazyVim/LazyVim/commit/1e1b68d633d4bd4faa912ba5f49ab6b8601dc0c9
    -- it means that Neotest can properly work with nvim-treesitter when lazy-loaded. Apparently
    -- Neotest never actually require the nvim-treesitter module.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
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
      highlight = {
        enable = true;
        enable_autocmd = true,
      },
      indent = {
        enable = false,
        enable_autocmd = true,
      },
    }
  end
}
