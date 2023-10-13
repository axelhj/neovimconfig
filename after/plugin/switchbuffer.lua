local function feedkeys_replace_termcodes_n(cmd)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(cmd, true, false, true),
    'n',
    false
  )
end

local function get_relative_focus_buffer_func(direction)
  return function()
    if require'neotree-focused'.is_neotree_focused() then
      feedkeys_replace_termcodes_n('<C-w>l')
      return
    end
    if direction == 1 then
      vim.api.nvim_exec2('bnext', {})
    else
      vim.api.nvim_exec2('bprevious', {})
    end
  end
end

local function get_exec_unescaped_buffer(cmd)
  return function()
    if not require'neotree-focused'.is_neotree_focused() then
      feedkeys_replace_termcodes_n(cmd)
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
  get_exec_unescaped_buffer('<Esc>:bnext<cr>'),
  {
  desc = 'Switch to next open buffer' }
)

vim.keymap.set( 'i', '<S-C-Tab>',
  get_exec_unescaped_buffer('<Esc>:bprevious<cr>'),
  {
  desc = 'Switch to previous open buffer' }
)

vim.keymap.set('n', 'bd',function()
  vim.cmd(':Bdelete')
end, {
  desc = 'Close a buffer and delete if not displayed elsewhere'
})
