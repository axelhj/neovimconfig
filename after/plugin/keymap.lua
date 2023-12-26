local replace_termcodes = require"feedkeys".replace_termcodes

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

vim.keymap.set('n', '<Leader>gbn', ":enew<Cr>",
  { desc = 'Edit new buffer [gbn]', silent = true }
)

vim.keymap.set('n', '<Leader>gtn', ":tabnew<Cr>",
  { desc = 'Add tab [gtn]', silent = true }
)

vim.keymap.set('n', '<Leader>w', ':Bunlink<Cr>',
  { desc = 'Close buffer, open next and keep [w]indow' }
)

vim.keymap.set('n', '<Leader>W', ':tabclose<Cr>',
  { desc = 'Close current tab (window/split-setup) [W]' }
)

vim.keymap.set('n', '<Leader>bd', ':bdelete!<Cr>',
  { desc = 'Close a [b]uffer, [d]iscard changes and close the window' }
)

vim.keymap.set('n', '<Leader>dt',
  function() require'trouble'.toggle() end,
  { desc = 'Open/Close the Trouble sidebar' }
)

vim.keymap.set("n", "<Leader>q!", ":q!<Cr>",
  { desc = 'Close the current window and discard changes' }
)

vim.keymap.set("n", "<Leader>-", ":LspRestart<Cr>",
  { desc = 'Execute LspRestart', silent = true }
)

vim.keymap.set("n", "<C-Up>", ":tabnew<Cr>",
  { desc = 'Add tab', silent = true }
)

vim.keymap.set("n", "<C-Down>", ":tabclose<Cr>",
  { desc = 'Close tab', silent = true }
)
