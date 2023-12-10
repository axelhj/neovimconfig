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
    require("persisted").setup({
      autosave = true,
      -- Autosave means autosave any session IIF autocrate is also set as true.
      autocreate = true,
      -- This is documented to be the default value but somehow crashes on branch separator config missing:
      use_git_branch = false,
      -- Will crash on SessionSave if this is set as nil, which it is by default.
      branch_separator = "",
    })
  end,
}
