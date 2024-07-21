-- Load with `nvim --clean -u %LOCALAPPDATA%\nvim\minimal-init.lua`

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath"data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local function feedkeys_replace_termcodes(cmd)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(cmd, true, false, true),
    "m", false
  )
end

local function toggle_term()
  local should_restore_mark = require "toggleterm.ui".find_open_windows() and
    vim.o.buftype ~= "terminal"
  if should_restore_mark then feedkeys_replace_termcodes("mT") end
  local tabpagenr = vim.fn.tabpagenr()
  if vim.v.count > 0 then
    vim.cmd(":ToggleTerm "..vim.v.count)
  else
    vim.cmd(":ToggleTerm")
  end
  if should_restore_mark then feedkeys_replace_termcodes(tabpagenr.."gt`T") end
end

vim.keymap.set({ "t" }, "<M-x>", "<C-\\><C-n>",
  { silent = true, desc = "Be able to close terminal on Windows/EU keyboard" }
)

require("lazy").setup({
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      -- Toggleterm auto-switches tabs if already open in another.
      { "<Leader>t", "<Cmd>ToggleTerm<Cr>", mode = "n", { desc = "Toggle [ t]erm", silent = true } },
      -- Toggleterm without switching tabs if already open in another.
      { "<C-Cr>", toggle_term, mode = "n", { desc = "Toggle term", silent = true } }
    },
    opts = {
      open_mapping = false,
      insert_mappings = false,
      terminal_mappings = false,
      start_in_insert = false,
      autochdir = true,
      direction = "horizontal",
    }
  }
})
