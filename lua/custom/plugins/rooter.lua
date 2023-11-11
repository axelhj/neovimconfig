return {
  'notjedi/nvim-rooter.lua',
  config = function ()
    require'nvim-rooter'.setup({
      rooter_patterns = { 'dap.log', 'src/', '.git', '.hg', '.svn' },
    })
  end,
}

