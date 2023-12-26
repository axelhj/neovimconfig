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

-- Enable break-indent - indent autowrapped line-continuations.
vim.o.breakindent = true

-- Auto indent when a new line is opened.
vim.o.autoindent = true

-- Don't preserve broken indent - stick to multiples rather than incorporate
-- broken (non-divisible by eg. 4) indentation on following lines:
vim.o.shiftround = true

-- Use shiftwidth for C-indent if enabled.
vim.o.cinoptions = "1s"

-- Disable wonky Neovim indent. Double-indents following {
-- if using "cc" (change line)
vim.o.indentexpr = ""

-- Python ft config really messes up indenting badly - indenting
-- follow-on indents by multiples.
vim.g.pyindent_open_paren = '&sw'
vim.g.pyindent_nested_paren = '&sw'
vim.g.pyindent_continue = '&sw'

-- Save undo history
vim.o.undofile = true

-- Case-sensitive searching
vim.o.ignorecase = false
vim.o.smartcase = false

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
vim.go.signcolumn = 'yes'
vim.o.signcolumn = 'yes'

-- Set updatetime - swapfile writing
-- and CursorHold events timeout (ms).
vim.o.updatetime = 75

-- Timeout after waiting for certain inputs.
vim.o.timeoutlen = 7500

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
vim.go.termguicolors = true

-- Keymaps for better default experience - kickstart.nvim
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

-- Messages:
-- A: Make the "file open in other session" warning
--   less intrusive/frequent
-- I: Eliminate vim startup wall of text
vim.o.shortmess="AI"

-- Useful font config - installed from nerdfonts.com
vim.o.guifont = "Inconsolata Nerd Font Mono:h9"

-- Setting that is useful for sending proper path separators to netcoredbg.
vim.o.shellslash = false

-- Keep some context visible at top and bottom. Absolute linecount,
-- context visible for j/k scrolling.
vim.o.scrolloff = 4

-- Context visible for jump/search scrolling. Appears to apply for j/k
-- scrolling too. Absolute number or percentage linecount with -n works too.
vim.o.scrolljump = 1

-- Horizontal scrolloff if nowrap is set/wrap is disabled. Absolute linecount.
vim.o.sidescrolloff = 6

-- signcolumn - show breakpoint column [auto, auto:[1-9], auto:[1-8:2-9], no, yes, yes:[1-9, number]
-- Numner/range sets maximum or min-maximum
vim.o.signcolumn = "yes:2"

-- Deal with transparency - make nvim-qt look more interesting.
if vim.v.vim_did_enter == 1 then
  vim.cmd 'GuiWindowOpacity 0.975'
end

vim.keymap.set({ 'n', 'v' }, '<Leader>gtt', ':terminal<CR>', { silent = true, desc = "Open a terminal program in the current buffer" })

vim.keymap.set({ 't' }, '<C-x>', '<C-\\><C-n>', { silent = true, desc = "Leave input mode of the open terminal" })

vim.keymap.set({ 'n', 'v' }, '<C-S-v>', '"*P', { silent = true, desc = "Desktop style paste shortcut" })

vim.keymap.set({ 'i' }, '<C-S-v>', '<Esc>"*Pi', { silent = true, desc = "Desktop style paste shortcut" })

vim.keymap.set({ 'n', 'v' }, '<C-S-c>', '"*y', { silent = true, desc = "Desktop style copy shortcut" })

vim.keymap.set({ 'n', 'v' }, '<C-S-x>', '"*d', { silent = true, desc = "Desktop style cut shortcut" })

-- Do not comment line following comment on <Cr>, <C-o>
vim.opt.formatoptions:remove { "c", "r", "o" }

-- Workaround because some Nvim ftplugin:s messes with the formatoptions-setting.
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
})

-- Display buffername in terminal title
vim.o.title = true

return M
