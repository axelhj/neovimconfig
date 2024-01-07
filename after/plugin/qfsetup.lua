local replace_termcodes = require"feedkeys".replace_termcodes
local replace_termcodes_async = require"feedkeys".replace_termcodes_async

if vim.fn.executable("rg") == 1 then
  vim.o.grepprg = "rg --path-separator / --vimgrep"
  vim.o.grepformat = "%f:%l:%c:%m"
end

-- Vimgrep - Ripgrep

vim.keymap.set('v', '<Leader>sf', function()
  local buf_name = vim.fn.expand('%'):gsub('%\\', '.'):gsub('%/', '.')
  replace_termcodes('y:silent grep! <C-r>"<Cr>:copen<Cr>/' .. buf_name .. '<Cr>', false)
  local yank_contents = vim.fn.getreg('"')
  replace_termcodes('/' .. yank_contents .. '<Cr>', false)
end, {
  desc = 'Search in files with ripgrep in visual'
})

vim.keymap.set('n', '<Leader>sf', function()
  replace_termcodes_async(':silent grep "')
end, {
  desc = 'Search in files with ripgrep'
})

-- Quickfix list

vim.keymap.set('n', '<Leader>c', function()
  local buf_name = vim.fn.expand('%'):gsub('%\\', '.'):gsub('%/', '.')
  replace_termcodes(':copen<Cr>/' .. buf_name .. '<Cr>')
end, {
  desc = 'Open the quickfix list (:copen/bufname)'
})

vim.keymap.set('n', '<Leader>n', ':cnext<Cr>',  {
  desc = 'Go to [n]ext quickfix list item (:cnext)'
})

vim.keymap.set('n', '<Leader>p', ':cprevious<Cr>', {
  desc = 'Go to [p]revious quickfix list item (:cprev)'
})

vim.keymap.set('n', '<Leader>qq', 'mZ:silent cclose<Cr>`Z', {
  desc = 'Close quickfix list [qq] (mZ:cclose´Z)'
})

-- Location list

vim.keymap.set('n', '<Leader>ll', function()
  local buf_name = vim.fn.expand('%'):gsub('%\\', '.'):gsub('%/', '.')
  replace_termcodes(':lopen<Cr>/' .. buf_name .. '<Cr>', false)
end, {
  desc = 'Open the [l]ocation list (:lopen/bufname)'
})

vim.keymap.set('n', '<Leader>ln', ':lnext<Cr>',  {
  desc = 'Go to next [l]ocation list [n] item (:lnext)'
})

vim.keymap.set('n', '<Leader>lp', ':lprevious<Cr>', {
  desc = 'Go to previous [l]ocation list [p] item (:lprev)'
})

vim.keymap.set('n', '<Leader>ql', 'mZ:silent lclose<Cr>`Z', {
  desc = 'Close location list [ql] (mZ:lclose´Z)'
})
