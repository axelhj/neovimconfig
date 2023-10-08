return {
  'notjedi/nvim-rooter.lua',
  config = function ()
    require'nvim-rooter'.setup({
      rooter_patterns = { 'src/', '.git', '.hg', '.svn' },
    })
  end,
}

