local M = {}

function M.set_options()
  -- Configure ripgrep to ignore node-modules & .git-folders but
  -- not to interpret .gitignore. Use for grep-prg and configure
  -- for quickfix-compat.
  if vim.fn.executable("rg") == 1 then
    local ignore = "--glob !**/node_modules/**/* --glob=!**/.git/**/*"
    vim.o.grepprg = "rg -u -u "..ignore.." -F --path-separator \\ --vimgrep"
    vim.o.grepformat = "%f:%l:%c:%m"
  end
end

function M.set_keymaps()
  local replace_termcodes = require"semiplugins.feedkeys".replace_termcodes
  local replace_termcodes_async = require"semiplugins.feedkeys".replace_termcodes_async

  -- Vimgrep - Ripgrep
  vim.keymap.set("v", "<Leader>sf", function()
    local buf_name = vim.fn.expand("%"):gsub("%\\", "."):gsub("%/", ".")
    replace_termcodes("y:silent grep! <C-r>\"<Cr>:copen<Cr>/" .. buf_name .. "<Cr>", false)
    local yank_contents = vim.fn.getreg("\"")
    replace_termcodes("/" .. yank_contents .. "<Cr>", false)
  end, {
    desc = "Search in files with ripgrep in visual"
  })

  vim.keymap.set("n", "<Leader>sf", function()
    replace_termcodes_async(":silent grep \"")
  end, {
    desc = "Search in files with ripgrep"
  })

  -- Quickfix list
  vim.keymap.set("n", "<Leader>c", function()
    local buf_name = vim.fn.expand("%"):gsub("%\\", "."):gsub("%/", ".")
    replace_termcodes(":copen<Cr>/" .. buf_name .. "<Cr>")
  end, {
    desc = "Open the quickfix list (:copen/bufname)"
  })

  vim.keymap.set("n", "<Leader>j", ":cnext<Cr>",  {
    desc = "Go to [n]ext quickfix list item (:cnext)"
  })

  vim.keymap.set("n", "<Leader>k", ":cprevious<Cr>", {
    desc = "Go to [p]revious quickfix list item (:cprev)"
  })

  vim.keymap.set("n", "<Leader>qc", function()
      if vim.bo.buftype == "quickfix" then
        replace_termcodes(":silent cclose<Cr>")
      else
        replace_termcodes("mZ:silent cclose<Cr>`Z")
      end
    end,
    {
      desc = "Close quickfix list [qc] (mZ:cclose´Z)"
    }
  )

  -- Location list
  vim.keymap.set("n", "<Leader>l", function()
  local buf_name = vim.fn.expand("%"):gsub("%\\", "."):gsub("%/", ".")
    replace_termcodes(":lopen<Cr>/" .. buf_name .. "<Cr>", false)
  end, {
    desc = "Open the [l]ocation list (:lopen/bufname)"
  })

  vim.keymap.set("n", "<Leader>n", ":lnext<Cr>",  {
    desc = "Go to [n]ext location list item (:lnext)"
  })

  vim.keymap.set("n", "<Leader>p", ":lprevious<Cr>", {
    desc = "Go to [p]revious location list item (:lprev)"
  })

  vim.keymap.set("n", "<Leader>ql", "mZ:silent lclose<Cr>`Z", {
    desc = "Close location list [ql] (mZ:lclose´Z)"
  })
end

return M
