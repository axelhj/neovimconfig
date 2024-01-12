local replace_termcodes = require"feedkeys".replace_termcodes

-- Open next file in neotree.
vim.keymap.set('n', '<Cr>',
  function()
    if vim.bo.filetype == "qf" or vim.bo.filetype == "" then
      replace_termcodes('<Cr>', false)
    else
      replace_termcodes(':Neotree reveal<Cr><Down><Cr>', true)
    end
  end,
  {
    remap = true,
    desc = 'Go to neotree and reveal next file [<Cr>]'
  }
)

-- Toggleterm without switching tabs if already open.
vim.keymap.set('n', '<Leader>t', function()
    print ("Count "..vim.v.count)
    local should_restore_mark = require "toggleterm.ui".find_open_windows() and
      vim.o.buftype ~= 'terminal'
    if should_restore_mark then replace_termcodes("mT") end
    local tabpagenr = vim.call("tabpagenr")
    if vim.v.count > 0 then
      vim.cmd(":ToggleTerm "..vim.v.count)
    else
      vim.cmd(":ToggleTerm")
    end
    if should_restore_mark then replace_termcodes(tabpagenr.."gt`T") end
  end,
  { desc = 'Toggle [t]erm', silent = true }
)

-- Tab, buffer & window-management related shortcuts.
vim.keymap.set('n', '<Leader>gbn', ":enew<Cr>",
  { desc = 'Edit new buffer [gbn]', silent = true }
)

vim.keymap.set('n', '<Leader>gtn', ":tabnew<Cr>",
  { desc = 'Add tab [gtn]', silent = true }
)

vim.keymap.set('n', '<Leader>gtd', ":tabclose<Cr>",
  { desc = 'Close tab [gtn]', silent = true }
)

vim.keymap.set('n', '<Leader>w', ':Bunlink<Cr>',
  { desc = 'Close buffer, open next and keep [w]indow' }
)

vim.keymap.set('n', '<Leader>W', ':tabclose<Cr>',
  { desc = 'Close current tab [W]' }
)

vim.keymap.set('n', '<Leader>bd', ':bdelete!<Cr>',
  { desc = 'Close a [b]uffer, [d]iscard changes and close the window' }
)

vim.keymap.set("n", "<Leader>q!", ":q!<Cr>",
  { desc = 'Close the current window and discard changes' }
)

vim.keymap.set("n", "<C-Up>", ":tabnew<Cr>",
  { desc = 'Add tab', silent = true }
)

vim.keymap.set("n", "<C-Down>", ":tabclose<Cr>",
  { desc = 'Close tab', silent = true }
)

-- Toggle trouble.
vim.keymap.set('n', '<Leader>dt',
  function() require'trouble'.toggle() end,
  { desc = 'Open/Close the Trouble sidebar' }
)

-- Lsp management.
vim.keymap.set("n", "<Leader>-", ":LspRestart<Cr>",
  { desc = 'Run LspRestart', silent = true }
)

-- Remaps for dealing with word wrap - kickstart.nvim.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'",
  { expr = true, silent = true }
)
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'",
  { expr = true, silent = true }
)

-- Toggle terminal in current buffer.
vim.keymap.set({ 'n', 'v' }, '<Leader>gtt', ':terminal<CR>',
  { silent = true, desc = "Open a terminal program in the current buffer" })

-- Be able to leave input mode of terminal - applies with toggleterm too.
vim.keymap.set({ 't' }, '<C-x>', '<C-\\><C-n>',
  { silent = true, desc = "Leave input mode of the open terminal" }
)

-- Copy/paste related keymaps - * register.
vim.keymap.set({ 'n', 'v' }, '<C-v>', '"*p',
  { silent = true, desc = "Desktop style paste shortcut at location" }
)

vim.keymap.set({ 'n', 'v' }, '<C-S-v>', '"*P',
  { silent = true, desc = "Desktop style paste shortcut after location" }
)

vim.keymap.set({ 'i' }, '<C-S-v>', '<Esc>"*pi',
  { silent = true, desc = "Desktop style paste shortcut at location" }
)

vim.keymap.set({ 'n', 'v' }, '<C-S-c>', '"*y',
  { silent = true, desc = "Desktop style copy/yank shortcut" }
)

vim.keymap.set({ 'n', 'v' }, '<C-S-x>', '"*d',
  { silent = true, desc = "Desktop style cut/delete shortcut" }
)

vim.keymap.set({ 'n', 'v', 'i' }, '<C-1>', '5<C-y>',
  { silent = true, desc = "Scroll -5" }
)

vim.keymap.set({ 'n', 'v', 'i' }, '<C-2>', '5<C-e>',
  { silent = true, desc = "Scroll +5" }
)
