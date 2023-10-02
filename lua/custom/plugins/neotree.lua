return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      window = {
        position = "left",
        width = 40,
      },
      filesystem = {
        filtered_items = {
          visible = true
        },
        window = {
          mappings = {
            -- Disable fuzzy finder
            ["/"] = "noop",
            ["?"] = "noop"
          }
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true
        }
      },
      buffers = {
        bind_to_cwd = true,
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true
        }
      }
    })
    vim.cmd([[nnoremap \ :Neotree reveal_force_cwd<cr>]])
  end
}

