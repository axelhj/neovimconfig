local M = {}

function M.is_win()
  return vim.fn.has("win32") + vim.fn.has("win64") ~= 0
end

return M
