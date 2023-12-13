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
        mappings = {
          ['<C-S-h>'] = "close_node",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true
        },
        window = {
          mappings = {
            -- Disable fuzzy finder
            ["<C-S-l>"] = "open",
            ["/"] = "noop",
            ["?"] = "noop"
          }
        },
        bind_to_cwd = true,
        cwd_target = {
           sidebar = "tab", -- sidebar is when position = left or right
           current = "tab" -- current is when position = current
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true
        },
        async_directory_scan = "always"
      },
      buffers = {
        bind_to_cwd = true,
        cwd_target = {
           sidebar = "tab", -- sidebar is when position = left or right
           current = "tab" -- current is when position = current
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true
        }
      }
    })
    vim.cmd([[nnoremap \ :Neotree reveal_force_cwd toggle<cr>]])
  end
}

