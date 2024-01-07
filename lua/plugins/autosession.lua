local replace_termcodes = require"feedkeys".replace_termcodes

local function split(value, separator)
  local result = {}
  value:gsub(
    "([^"..separator.."]*)"..separator,
    function(part) table.insert(result, part) end
  )
end

local function neotree_toggle()
  if vim.g.NEOTREE_LAST_OPENED then
    require("neo-tree.command")
      .execute {
        action = 'show',
        reveal = true,
      }
    -- The termcode has No effect unless preceded by a wait.
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
    print("Saving session "..file_path.." failed. "..vim.inspect(result))
  else
    print("Did save session "..file_path)
  end
end

local function pre_save()
  -- Store as a global variable such that neotree will open on
  -- restore if it was open at end of last session.
  vim.api.nvim_set_var(
    "NEOTREE_LAST_OPENED",
    require('neotreeopened').is_neotree_open()
  )
  -- The global variable is not saved on Neovim exit, or saved
  -- before the autosave is triggered. Write shada explicitly.
  --        vim.cmd(":wshada")
  if vim.g.NEOTREE_LAST_OPENED then
    vim.cmd(':Neotree close')
    require"toggleterm".toggle_all("close")
  end
end

local function post_restore()
  neotree_toggle()
end

local function init()
  local session_file_path = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/session.vim")
--  options = split(vim.o.sessionoptions, ","),
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
