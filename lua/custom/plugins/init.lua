return {
  {'scalameta/nvim-metals', dependencies = { "nvim-lua/plenary.nvim" }},
  {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function ()
      require("neo-tree").setup({
        window = {
          position = "left",
          width = 40,
        },
        filesystem = {
          window = {
            mappings = {
              -- Disable fuzzy finder
              ["/"] = "noop",
              ["?"] = "noop"
            }
          }
        }
      })
      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end
  }
}
