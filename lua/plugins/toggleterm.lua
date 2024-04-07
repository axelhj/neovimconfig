local toggle_term = require"semiplugins.toggletermutils".toggle_term

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    -- Toggleterm without switching tabs if already open.
    { "<Leader>t", toggle_term, mode = "n", { desc = "Toggle [ t]erm", expr = true, silent = true } },
    -- Toggleterm without switching tabs if already open, secondary mappings.
    {"<C-Cr>", toggle_term, mode = "n", { desc = "Toggle term [<C-Cr>]", expr = true, silent = true } },
    {"<C-Cr>", toggle_term, mode = "t", { desc = "Toggle term [<C-Cr>]", expr = true, silent = true } },
  },
  opts = {
    open_mapping = false,
    insert_mappings = false,
    terminal_mappings = false,
    start_in_insert = false,
    auto_scroll = false,
    autochdir = true,
    direction = "horizontal",
  }
}
