-- ftplugin/neo-tree-popup.lua

-- Workaround/hack to "unlock" modal renaming of files inside neo-tree. Credits go
-- to alanoliveira: https://github.com/nvim-neo-tree/neo-tree.nvim/issues/602#issuecomment-1382689052

local timer = vim.loop.new_timer()
-- Timer is necessary because the maps are added after the popup is created
timer:start(100, 0, vim.schedule_wrap(function()
  local esc_maps = vim.tbl_filter(function(m)
    return m.lhs == "<Esc>"
  end, vim.api.nvim_buf_get_keymap(0, "i"))

  if #esc_maps ~= 1 then
    vim.notify("0 or more than 1 '<Esc>' maps were found. Aborting.", 4)
    return
  end

  local close_map = esc_maps[1]
  vim.keymap.del(close_map.mode, close_map.lhs, { buffer = close_map.buffer })
  vim.keymap.set("n", close_map.lhs, close_map.callback, { buffer = close_map.buffer })
end))
