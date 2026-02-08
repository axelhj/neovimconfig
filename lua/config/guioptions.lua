M = {}

function M.set_options()
  -- Useful font config - installed from nerdfonts.com
  if vim.g.neovide then
    vim.g.neovide_scroll_animation_length=0.05
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.cmd"nnoremap <M-Cr> <Cmd>let g:neovide_fullscreen = g:neovide_fullscreen == v:false<Cr>"
    vim.keymap.set({ "n", "v" }, "<C-ScrollWheelUp>", "<Cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-ScrollWheelDown>", "<Cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
    vim.o.guifont = "IntoneMono NFM:h7"
  elseif vim.g.nvy then
    vim.o.guifont = "IntoneMono NFM:h7"
  else
    vim.o.guifont = "IntoneMono NFM:h9"
  end
end

return M
