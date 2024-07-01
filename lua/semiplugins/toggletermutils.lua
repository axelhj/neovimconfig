local M = {}

local replace_termcodes = require"semiplugins.feedkeys".replace_termcodes

function M.toggle_term()
  local should_restore_mark = require "toggleterm.ui".find_open_windows() and
    vim.o.buftype ~= "terminal"
  if should_restore_mark then replace_termcodes("mT") end
  local tabpagenr = vim.fn.tabpagenr()
  if vim.v.count > 0 then
    vim.cmd(":ToggleTerm"..vim.v.count)
  else
    vim.cmd(":ToggleTerm")
  end
  if should_restore_mark then
    replace_termcodes(tabpagenr.."gt`T")
  else
    -- Toggleterm was opened
    replace_termcodes("<C-w>K")
  end
end

return M
