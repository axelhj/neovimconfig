M = {}

function M.replace_termcodes(cmd, remap)
  local opts = "x"
  if remap then
    opts = opts.."m"
  else
    opts = opts.."n"
  end
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(cmd, true, false, true),
    opts,
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
