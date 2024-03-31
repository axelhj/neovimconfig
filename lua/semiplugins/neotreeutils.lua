M = {}

local replace_termcodes = require"semiplugins.feedkeys".replace_termcodes

function M.is_neotree_focused()
    -- Get our current buffer number
    local bufnr = vim.api.nvim_get_current_buf and vim.api.nvim_get_current_buf() or vim.fn.bufnr()
    -- Get all the available sources in neo-tree
    for _, source in ipairs(require("neo-tree").config.sources) do
        -- Get each sources state
        local state = require("neo-tree.sources.manager").get_state(source)
        -- Check if the source has a state, if the state has a buffer and if the buffer is our current buffer
        if state and state.bufnr and state.bufnr == bufnr then
            return true
        end
    end
    return false
end

function M.bind_focus_next_buffer_for_direction(direction)
  return function()
    if require("semiplugins.neotreeutils").is_neotree_focused() then
      replace_termcodes('<C-w>l', false)
      return
    end
    local is_empty = vim.bo.filetype == ''
    if is_empty and direction == 1 then
      vim.api.nvim_command('bnext!')
    elseif is_empty and direction == -1 then
      vim.api.nvim_command('bprev!')
    elseif direction == 1 then
      vim.api.nvim_command('BufferLineCycleNext')
    elseif direction == -1 then
      vim.api.nvim_command('BufferLineCyclePrev')
    end
  end
end

function M.bind_for_non_neotree_buffer(cmd)
  return function()
    if not require("semiplugins.neotreeutils").is_neotree_focused() then
      replace_termcodes(cmd, false)
    end
    return nil
  end
end

function M.resize()
  -- Get our current buffer number
  local tn = vim.api.nvim_get_current_tabpage()
  local tree_win_handle = nil
  for _, window_handle in ipairs(vim.api.nvim_tabpage_list_wins(tn)) do
    local buffer_handle = vim.api.nvim_win_get_buf(window_handle)
    local buf_name = vim.fn.bufname(buffer_handle)
    if buf_name:match("^neo%-tree %w+ %[%d+%]$") then
      tree_win_handle = window_handle
      break
    end
  end
  if tree_win_handle == nil then
    -- Did not find window for neo-tree, could not reset size.
    return
  end
  local configured_width = require("neo-tree").config.filesystem.window.width or 40
  if vim.api.nvim_win_get_width(tree_win_handle) > configured_width then
    -- Reset neo-tree window size to proper value.
    vim.api.nvim_win_set_width(tree_win_handle, configured_width)
    return
  end
  -- Did not find window in tabpage, could not reset size.
end

-- ftplugin/neo-tree-popup.lua

-- Workaround/hack to "unlock" modal renaming of files inside neo-tree. Credits go
-- to alanoliveira: https://github.com/nvim-neo-tree/neo-tree.nvim/issues/602#issuecomment-1382689052
function M.neo_tree_popup_ftplugin()
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
end

--[[ Utils:
 - bind_focus_next_buffer_for_direction(direction) - switch the buffer for current window, or leave neotree.
 - bind_for_non_neotree_buffer(cmd) - call replace_termcodes and feedkey if the current buffer is not neotree.
 - is_neotree_focused() - whether the active buffer is the neotree.
 - resize() - reset the neotree window width as configured without switching.
]]--
return M
