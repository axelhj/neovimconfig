return {
  'rmagatti/auto-session',
  config = function()
    require("auto-session").setup {
      log_level = "error",
      auto_session_suppress_dirs = nil,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_enable_last_session =
        vim.loop.cwd() == vim.loop.os_homedir() or
        vim.loop.cwd() == vim.loop.os_homedir() .. '/Desktop',
      auto_session_create_enabled = true,
      pre_save_cmds = {'Neotree close'},
      pre_restore_cmds = {'Neotree close'},
      post_restore_cmds = {'Neotree show'},
    }
  end,
  lazy = false
}

