return {
  'prettier/vim-prettier',
  enabled = false,
  lazy = false,
  config = function()
    vim.cmd"let g:prettier#autoformat_config_present = 1"
    vim.cmd"let g:prettier#autoformat_require_pragma = 0"
    vim.cmd"let g:prettier#exec_cmd_async = 1"
    vim.cmd"let g:prettier#autoformat_config_files = ['.prettierrc.json', '.prettierrc']"
    vim.cmd"let g:prettier#config#config_precedence = 'prefer-file'"
    vim.cmd"let g:prettier#quickfix = 0"
    vim.cmd"let g:prettier#quickfix_enabled = 0"
    vim.cmd"let g:prettier#quickfix_auto_focus = 0"
  end,
}
