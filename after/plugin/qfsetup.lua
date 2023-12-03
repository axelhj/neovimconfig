local replace_termcodes = require"feedkeys".replace_termcodes
local replace_termcodes_async = require"feedkeys".replace_termcodes_async

if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --path-separator / --vimgrep"
  vim.o.grepformat = "%f:%l:%c:%m"
end

vim.keymap.set('v', '<Leader>sf', function()
  local buf_name = vim.fn.expand('%'):gsub('%\\', '.'):gsub('%/', '.')
  replace_termcodes('y:silent grep! <C-r>"<Cr>:copen<Cr>/' .. buf_name .. '<Cr>')
  local yank_contents = vim.fn.getreg('"')
  replace_termcodes('/' .. yank_contents .. '<Cr>')
end, {
  desc = 'Search in files with ripgrep in visual'
})

vim.keymap.set('n', '<Leader>sf', function()
  replace_termcodes_async(':silent grep "')
end, {
  desc = 'Search in files with ripgrep'
})

vim.keymap.set('n', '<Leader>ln', ':cnext<Cr>',  {
  desc = 'Go to next quickfix message'
})

vim.keymap.set('n', '<Leader>lp', ':cprevious<Cr>', {
  desc = 'Go to previous quickfix message'
})

vim.keymap.set('n', '<Leader>ls', function()
  local buf_name = vim.fn.expand('%'):gsub('%\\', '.'):gsub('%/', '.')
  replace_termcodes(':copen<Cr>/' .. buf_name .. '<Cr>')
end, {
  desc = 'Open the quickfix window'
})

vim.keymap.set('n', '<Leader>lq', 'mZ:silent cclose<Cr>`Z', {
  desc = 'Close quickfix window and return'
})
