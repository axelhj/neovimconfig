M = {}

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
vim.o.clipboard = ''

-- Enable break-indent - indent autowrapped lines continuations.
vim.o.breakindent = true

-- Auto indent when a new line is opened.
vim.o.autoindent = true

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
vim.go.termguicolors = true

-- Keymaps for better default experience - kickstart.nivim
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap - kickstart.nvim
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Help auto-session do its thing
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.o.shada = '\'1000,%'

-- Don't wrap around to the start/end once end/start is
-- reached in search.
vim.o.wrapscan = false

-- Softwrap long lines, linebreak by word.
vim.o.textwidth = 0
vim.o.wrapmargin = 0
vim.o.wrap = true
vim.o.linebreak = true

-- Make the "file open in other session" warning
-- less intrusive/frequent
vim.o.shortmess=A

-- Useful font config - installed from nerdfonts.com
vim.o.guifont = "Inconsolata Nerd Font Mono:h9"

-- Setting that is useful for sending proper path separators to netcoredbg.
vim.o.shellslash = false

-- Deal with transparency - make nvim-qt look more interesting.
if vim.v.vim_did_enter == 1 then
  vim.cmd 'GuiWindowOpacity 0.975'
end

vim.keymap.set({ 'n', 'v' }, '<Leader>gtt', ':terminal<CR>', { silent = true, desc = "Open a terminal program in the current buffer" })

vim.keymap.set({ 't' }, '<C-x>', '<C-\\><C-n>', { silent = true, desc = "Leave input mode of the open terminal" })

vim.keymap.set({ 'n', 'v' }, '<C-S-v>', '"*p', { silent = true, desc = "Desktop style paste shortcut" })

vim.keymap.set({ 'i' }, '<C-S-v>', '<Esc>"*pi', { silent = true, desc = "Desktop style paste shortcut" })

vim.keymap.set({ 'n', 'v' }, '<C-S-c>', '"*y', { silent = true, desc = "Desktop style copy shortcut" })

vim.keymap.set({ 'n', 'v' }, '<C-S-x>', '"*d', { silent = true, desc = "Desktop style cut shortcut" })

-- Do not comment line following comment on <Cr>, <C-o>
vim.opt.formatoptions:remove { "c", "r", "o" }

-- Workaround because some Nvim ftplugin:s messes with the formatoptions-setting.
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
})

return M