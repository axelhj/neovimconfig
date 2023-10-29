return {
  'notjedi/nvim-rooter.lua',
  config = function ()
    require'nvim-rooter'.setup({
      rooter_patterns = { '*.csproj', 'src/', '.git', '.hg', '.svn' },
    })
  end,
}

