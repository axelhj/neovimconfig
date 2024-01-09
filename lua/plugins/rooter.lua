vim.cmd [[
  let g:rooter_patterns = [ 'dap.log', 'src/', '.git', '.hg', '.svn' ]
  let g:rooter_change_directory_for_non_project_files = 'current'
  let g:rooter_silent_chdir = 1
]]
return { 'airblade/vim-rooter' }

