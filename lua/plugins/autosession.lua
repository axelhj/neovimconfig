local replace_termcodes = require"feedkeys".replace_termcodes

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

return {
  'rmagatti/auto-session',
  name = 'auto-session',
  lazy = true,
  -- Needs to be lazy in order for shada-file to be read before setup.
  event = "UIEnter",
  config = function()
    require'auto-session'.setup {
      log_level = 'error',
      auto_session_enable_last_session = true,
      auto_session_root_dir = vim.fn.stdpath('data').."/sessions/",
      -- auto_session_enabled is equivalent to auto_save_enabled, auto_restore_enabled
      auto_session_enabled = true,
      auto_session_suppress_dirs = {
        "$USERPROFILE",
        "$USERPROFILE\\Desktop",
      },
      auto_session_use_git_branch = nil,
      -- The configs below are lua only.
      bypass_session_save_file_types = nil,
      pre_save_cmds = {
        function()
          -- Store as a global variable such that neotree will open on
          -- restore if it was open at end of last session.
          vim.api.nvim_set_var("NEOTREE_LAST_OPENED", require('neotreeopened').is_neotree_open())
          -- The global variable is not saved on Neovim exit, or saved
          -- before the autosave is triggered. Write shada explicitly.
          vim.cmd(":wshada")
          if vim.g.NEOTREE_LAST_OPENED then
            vim.cmd(':Neotree close')
            require"toggleterm".toggle_all("close")
          end
        end
      },
      post_save_cmds = { neotree_toggle },
      cwd_change_handling = { restore_upcoming_session = false },
    }
    if vim.call("argc") == 0 then
      vim.cmd [[ SessionRestore ]]
      neotree_toggle()
    end
  end,
}
