local replace_termcodes = require"feedkeys".replace_termcodes

local function get_relative_focus_buffer_func(direction)
  return function()
    if require'neotree-focused'.is_neotree_focused() then
      replace_termcodes('<C-w>l')
      return
    end
    local is_empty = vim.bo.filetype == ''
    if is_empty and direction == 1 then
      vim.api.nvim_command('bnext!')
    elseif is_empty and direction == -1 then
      vim.api.nvim_command('bprev!')
    elseif direction == 1 then
      vim.api.nvim_command('BufferLineCycleNext')
    elseif direction == -1 then
      vim.api.nvim_command('BufferLineCyclePrev')
    end
  end
end

local function get_exec_unescaped_buffer(cmd)
  return function()
    if not require'neotree-focused'.is_neotree_focused() then
      replace_termcodes(cmd)
    end
    return nil
  end
end

-- Switch buffers quickly
vim.keymap.set('n', '<Tab>',
  get_relative_focus_buffer_func(1),
  { desc = 'Switch to next open buffer' }
)

vim.keymap.set('n', '<S-Tab>',
  get_relative_focus_buffer_func(-1),
  { desc = 'Switch to previous open buffer' }
)

vim.keymap.set('n', '<C-Tab>',
  get_relative_focus_buffer_func(1),
  { desc = 'Switch to next open buffer' }
)
vim.keymap.set('n', '<C-S-Tab>',
  get_relative_focus_buffer_func(-1),
  { desc = 'Switch to previous open buffer' }
)

vim.keymap.set('n', 'gn',
  get_relative_focus_buffer_func(1),
  { desc = 'Switch to next open buffer' }
)

vim.keymap.set('n', 'gp',
  get_relative_focus_buffer_func(-1),
  {
  desc = 'Switch to previous open buffer' }
)

vim.keymap.set( 'i', '<C-Tab>',
  get_exec_unescaped_buffer('<Esc>:BufferLineCycleNext<cr>'),
  {
  desc = 'Switch to next open buffer' }
)

vim.keymap.set( 'i', '<S-C-Tab>',
  get_exec_unescaped_buffer('<Esc>:BufferLineCyclePrev<cr>'),
  {
  desc = 'Switch to previous open buffer' }
)

vim.keymap.set('n', '<Leader>bb',function()
  vim.cmd(':Bdelete')
end, {
  desc = 'Close a [b]uffer and delete if not [d]isplayed elsewhere'
})

vim.keymap.set('n', '<Leader>bd',function()
  vim.cmd(':bdelete!')
end, {
  desc = 'Close a [b]uffer and [d]elete the window'
})

vim.keymap.set('n', '<Leader>dt',function()
  require'trouble'.toggle()
end, {
  desc = 'Open/Close the Trouble sidebar'
})

vim.keymap.set("n", "<Leader>q!", ":q!<Cr>", {
  desc = 'Close the current window and discard changes'
})
