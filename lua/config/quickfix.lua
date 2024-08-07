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

  -- Vimgrep - Ripgrep
  vim.keymap.set("v", "<Leader>fv", function()
    local buf_name = vim.fn.expand("%"):gsub("%\\", "."):gsub("%/", ".")
    replace_termcodes("y:silent grep! <C-r>\"<Cr>:copen<Cr>/" .. buf_name .. "<Cr>", false)
    local yank_contents = vim.fn.getreg("\"")
    replace_termcodes("/" .. yank_contents .. "<Cr>", false)
  end, {
    desc = "Search in files with ripgrep in visual"
  })

  -- Quickfix list
  vim.keymap.set("n", "<Leader>c", function()
    local buf_name = vim.fn.expand("%"):gsub("%\\", "."):gsub("%/", ".")
    replace_termcodes("<Cmd>copen<Cr>/" .. buf_name .. "<Cr>")
  end, {
    desc = "Open the quickfix list (:copen/bufname)"
  })

  vim.keymap.set("n", "<Leader>j", "<Cmd>cnext<Cr>",  {
    desc = "Go to [n]ext quickfix list item (:cnext)"
  })

  vim.keymap.set("n", "<Leader>k", "<Cmd>cprevious<Cr>", {
    desc = "Go to [p]revious quickfix list item (:cprev)"
  })

  vim.keymap.set("n", "<Leader>cx", function()
      if vim.bo.buftype == "quickfix" then
        replace_termcodes("<Cmd>silent cclose<Cr>")
      else
        replace_termcodes("mZ<Cmd>silent cclose<Cr>`Z")
      end
    end,
    {
      desc = "Close quickfix list [ cx] (mZ<Cmd>cclose´Z)"
    }
  )

  -- Location list
  vim.keymap.set("n", "<Leader>l", function()
  local buf_name = vim.fn.expand("%"):gsub("%\\", "."):gsub("%/", ".")
    replace_termcodes("<Cmd>lopen<Cr>/" .. buf_name .. "<Cr>", false)
  end, {
    desc = "Open the [l]ocation list (:lopen/bufname)"
  })

  vim.keymap.set("n", "<Leader>n", "<Cmd>lnext<Cr>",  {
    desc = "Go to [n]ext location list item (:lnext)"
  })

  vim.keymap.set("n", "<Leader>p", "<Cmd>lprevious<Cr>", {
    desc = "Go to [p]revious location list item (:lprev)"
  })

  vim.keymap.set("n", "<Leader>ql", "mZ:silent lclose<Cr>`Z", {
    desc = "Close location list [ql] (mZ:lclose´Z)"
  })
end

return M
