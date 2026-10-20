return {
  "airblade/vim-rooter",
  event = { "VeryLazy" },
  config = function()
    vim.g.rooter_patterns = { "dap.log", ".git", ".hg", ".svn" }
    vim.g.rooter_change_directory_for_non_project_files = "current"
    vim.g.rooter_silent_chdir = 1
  end
}
