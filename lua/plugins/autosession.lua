local replace_termcodes = require"feedkeys".replace_termcodes

local neotree_state = "NEOTREE_LAST_OPENED"

local function split(value, separator)
  local result = {}
  value:gsub(
    "([^"..separator.."]*)"..separator,
    function(part) table.insert(result, part) end
  )
  return result
end

local function neotree_toggle()
  if vim.g[neotree_state] then
    require("neo-tree.command")
      .execute {
        action = 'show',
        reveal_force_cwd = true,
      }
    -- The termcode has no effect unless preceded by a wait.
    vim.wait(0)
    replace_termcodes("<C-w>=", false)
  end
end

local function save(file_path)
  vim.cmd("mksession! " .. file_path)
end

local function restore(file_path)
  local cmd = "silent source " .. file_path
  local success, result = pcall(vim.cmd, cmd)
  if not success then
    print("Restoring session "..file_path.." failed. "..vim.inspect(result))
  end
end

local function pre_save()
  -- Store as a global variable such that neotree will open on
  -- restore if it was open at end of last session.
  vim.api.nvim_set_var(
    neotree_state,
    require('neotreeopened').is_neotree_open()
  )
  -- Close the Neo-tree window for each tab.
  replace_termcodes('mO')
  vim.cmd ':tabdo Neotree close'
  -- Close any open Toggleterm-terminals.
  if require "toggleterm.ui".find_open_windows() then
    require "toggleterm".toggle_all()
  end
  replace_termcodes('`O')
  -- Doesn't autosave after VimLeave.
  vim.cmd(":wshada")
end

local function post_restore()
  neotree_toggle()
end

local function init()
  local session_file_path = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/session.vim")
  vim.api.nvim_create_autocmd(
    'VimLeave',
    {
      callback = function()
        pre_save()
        save(session_file_path)
      end
    }
  )
  if vim.call("argc") == 0 then
    vim.api.nvim_create_autocmd(
      'UIEnter',
      {
        callback = function()
          restore(session_file_path)
          post_restore()
        end
      }
    )
  end
end

init()

return {}
