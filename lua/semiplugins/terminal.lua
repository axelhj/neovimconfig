local M = {}

function M.terminal_resize_horizontal(max_height)
  -- Get our current buffer number
  local tn = vim.api.nvim_get_current_tabpage()
  local tree_win_handle = nil
  for _, window_handle in ipairs(vim.api.nvim_tabpage_list_wins(tn)) do
    local buffer_handle = vim.api.nvim_win_get_buf(window_handle)
    local buf_name = vim.fn.bufname(buffer_handle)
    if buf_name:match("%d+:.*toggleterm|^toggleterm$") or
      vim.bo[vim.fn.bufnr(buffer_handle)].buftype == "terminal"
    then
    tree_win_handle = window_handle
      break
    end
  end
  if tree_win_handle ~= nil and
    vim.api.nvim_win_get_height(tree_win_handle) > max_height
  then
    -- Reset neo-tree window size to proper value.
    vim.api.nvim_win_set_height(tree_win_handle, max_height)
    return
  end
end

return M
