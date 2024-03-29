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
  local success, result = pcall(function(arg) vim.cmd(arg) end, cmd)
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
  -- Remember current tab and set mark in case
  -- closing tree or terminal switches tab.
  local tabpagenr = vim.fn.tabpagenr()
  local should_restore_mark = require "toggleterm.ui".find_open_windows() and
    vim.o.buftype ~= 'terminal'
  replace_termcodes('mT')
  -- Close the Neo-tree window for each tab.
  vim.cmd ':tabdo Neotree close'
  -- Close any open Toggleterm-terminals.
  if require "toggleterm.ui".find_open_windows() then
    require "toggleterm".toggle_all()
  end
  if should_restore_mark then replace_termcodes(tabpagenr.."gt`T") end
  -- Doesn't autosave after VimLeave.
  vim.cmd(":wshada")
end

local function post_restore()
  neotree_toggle()
end

local function is_plugin_blocked(block_filetypes, block_filenames)
  if vim.fn.argc() ~= 0 then return true end
  for _, filetype in ipairs(block_filetypes) do
    if filetype == vim.o.filetype then
      return true
    end
  end
  for _, filename in ipairs(block_filenames) do
    local buf_filename = vim.fn.fnamemodify(vim.fn.bufname(), ":t")
    if filename == buf_filename then
      return true
    end
  end
  return false
end

local function init()
  local session_file_path = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/session.vim")
  local block_filetypes = { "netrw", "gitcommit" }
  local block_filenames = { "GIT_COMMIT", "COMMIT_EDITMSG" }
  vim.api.nvim_create_autocmd(
    'VimLeave',
    {
      callback = function()
        if is_plugin_blocked(block_filetypes, block_filenames) then return end
        pre_save()
        save(session_file_path)
      end
    }
  )
  vim.api.nvim_create_autocmd(
    'UIEnter',
    {
      callback = function()
        if is_plugin_blocked(block_filetypes, block_filenames) then return end
        restore(session_file_path)
        post_restore()
      end
    }
  )
end

init()

return {}
