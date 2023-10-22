return {
  "olimorris/persisted.nvim",
  config = function()
    local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {}) -- A global group for all your config autocommands
    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = "SessionSavePre",
      group = config_group,
      callback = function()
        vim.cmd('Neotree close')
        vim.cmd('TroubleClose')
      end,
    })
  end,
}
