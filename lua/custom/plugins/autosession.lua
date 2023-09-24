return {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      log_level = "error",
      auto_session_suppress_dirs = {},
      auto_restore_enabled = true,
      -- auto_session_enable_last_session = false, -- even if not existing
      auto_session_enable_last_session =
        vim.loop.cwd() == vim.loop.os_homedir(),
      restore_upcoming_session = true,
      pre_save_cmds = {'Neotree close'},
      post_restore_cmds = {'Neotree reveal_force_cwd'}
    }
  end
}

