M = {}

function M.replace_termcodes(cmd)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(cmd, true, false, true),
    'xn',
    false
  )
end

function M.replace_termcodes_async(cmd)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(cmd, true, false, true),
    'n',
    false
  )
end

return M
