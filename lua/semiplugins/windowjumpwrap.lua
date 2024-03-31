local M = {}

-- When using <C-w>h, <C-w>j, <C-w>k or <C-w>l to jump to the next
-- window of the tab, wrap aroud once the edge is reached.
-- Credit: https://stackoverflow.com/a/73612761

function M.try_jump_window(direction, count)
  local prev_win_nr = vim.fn.winnr()
  vim.cmd(count .. "wincmd " .. direction)
  return vim.fn.winnr() ~= prev_win_nr
end

function M.jump_window_with_wrap(direction, opposite)
  return function ()
    if not M.try_jump_window(direction, vim.v.count1) then
      M.try_jump_window(opposite, 999)
    end
  end
end

return M
