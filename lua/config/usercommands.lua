local M = {}

function M.set_user_commands()
  -- Avoid showing which-key overline every other time when saving a file.
  vim.api.nvim_create_user_command("W", ":w", {})
end

return M
