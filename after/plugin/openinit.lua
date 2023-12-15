-- On windows - edit Neovim config init
local lua_init_location = vim.fn.stdpath("config") .. "/init.lua"

vim.keymap.set({ 'n' }, '<C-S-i>', ':e ' .. lua_init_location .. '<Cr>', {
  silent = true, desc = "Edit init.lua"
})
