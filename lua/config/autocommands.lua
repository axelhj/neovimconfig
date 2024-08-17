local M = {}

function M.set_autocommands()
  -- Show diagnostics under the cursor when holding position.
  -- Does so by checking if a floating dialog exists and if not
  -- then check for and shows any diagnostics under the cursor.
  -- By courtesy of https://neovim.discourse.group/t/how-to-show-diagnostics-on-hover/3830/3
  vim.api.nvim_create_augroup("lsp_diagnostics_hold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
      for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
          return
        end
      end
      -- THIS IS FOR BUILTIN LSP
      vim.diagnostic.open_float(nil, {
        scope = "cursor",
        focusable = false,
        close_events = {
          "CursorMoved",
          "CursorMovedI",
          "BufHidden",
          "InsertCharPre",
          "WinLeave",
        },
        syntax = "on"
      })
    end,
    group = "lsp_diagnostics_hold",
  })

  -- Highlight on yank
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {
    clear = true
  })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  })

  -- Autocommand to enable workaround so that vim
  -- motions can be used inside the neo-tree rename-buffer.
  vim.api.nvim_create_augroup("neo_tree_popup", { clear = true })
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "neo-tree-popup",
    callback = require"semiplugins.neotreeutils".neo_tree_popup_ftplugin,
    group = "neo_tree_popup",
  })

  -- Autocommand to enable workaround so that terminal splits
  -- don't grow when a window underneath (qf) is closed.
  vim.api.nvim_create_augroup("toggleterm_resize", { clear = true })
  vim.api.nvim_create_autocmd({ "WinClosed" }, {
    callback = function(event)
      if vim.bo[0].buftype ~= "quickfix" then
        return
      end
      local timer = vim.loop.new_timer()
      timer:start(30, 0, vim.schedule_wrap(
        function()
          require"semiplugins.terminal".terminal_resize_horizontal(14)
        end
      ))
    end,
    group = "toggleterm_resize",
  })
end

return M
