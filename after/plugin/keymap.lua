local replace_termcodes = require"feedkeys".replace_termcodes

vim.keymap.set('n', '<Cr>',
  function()
    if vim.bo.filetype == "qf" or vim.bo.filetype == "" then
      replace_termcodes('<Cr>', false)
    else
      replace_termcodes(':Neotree reveal<Cr><C-W>h<Down><Cr>', true)
    end
  end,
  {
    remap = true,
    desc = 'Go to neotree and reveal next file [<Cr>]'
  }
)

vim.keymap.set('n', '<Leader>w', ':Bdelete<Cr>',
  { desc = 'Close a last instance of buffer [w]ithout writing' }
)

vim.keymap.set('n', '<Leader>bd', ':bdelete!<Cr>',
  { desc = 'Close a [b]uffer, [d]iscard changes and delete the window' }
)

vim.keymap.set('n', '<Leader>dt',
  function() require'trouble'.toggle() end,
  { desc = 'Open/Close the Trouble sidebar' }
)

vim.keymap.set("n", "<Leader>q!", ":q!<Cr>",
  { desc = 'Close the current window and discard changes' }
)
