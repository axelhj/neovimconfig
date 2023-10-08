-- Set highlight on search
vim.o.hlsearch = true
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-sensitive searching
vim.o.ignorecase = false
vim.o.smartcase = false

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Keymaps for better default experience - kickstart.nivim
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap - kickstart.nivim
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Help auto-session do its thing
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Don't wrap around to the start/end once end/start is
-- reached in search.
vim.o.wrapscan = false

-- Useful font config - installed from nerdfonts.com
vim.o.guifont = "Inconsolata Nerd Font Mono:h9"

-- Deal with transparency - make nvim-qt look more interesting.
vim.cmd 'GuiWindowOpacity 0.975'

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

-- Quick split/window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
