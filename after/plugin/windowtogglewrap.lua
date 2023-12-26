-- When using <C-w>h, <C-w>j, <C-w>k or <C-w>l to jump to the next
-- window of the tab, wrap aroud once the edge is reached.
-- Credit: https://stackoverflow.com/a/73612761

local function try_jump_window(direction, count)
  local prev_win_nr = vim.fn.winnr()
  vim.cmd(count .. "wincmd " .. direction)
  return vim.fn.winnr() ~= prev_win_nr
end

local function jump_window_with_wrap(direction, opposite)
  return function ()
    if not try_jump_window(direction, vim.v.count1) then
      try_jump_window(opposite, 999)
    end
  end
end

local opts = { silent = true, noremap = true, desc = "Switch window/split" }

vim.keymap.set("n", "<C-h>", jump_window_with_wrap("h", "l"), opts)
vim.keymap.set("n", "<C-l>", jump_window_with_wrap("l", "h"), opts)
vim.keymap.set("n", "<C-j>", jump_window_with_wrap("j", "k"), opts)
vim.keymap.set("n", "<C-k>", jump_window_with_wrap("k", "j"), opts)
