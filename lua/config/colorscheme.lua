local M = {}

local function read_name()
  return io.lines(vim.fn.stdpath("config") .. "/colorscheme.txt")()
end

function M.set_colorscheme(default)
  local ok, colorscheme = pcall(read_name)
  local use_default = true
  if ok then
    ok = pcall(vim.cmd, "colorscheme "..colorscheme)
    if ok then
      use_default = false
    end
  end
  if use_default then
    vim.cmd("colorscheme "..default)
  end
end

return M
