return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    { 'scalameta/nvim-metals', dependencies = { "nvim-lua/plenary.nvim" }},
    'folke/neodev.nvim',
  },
}

