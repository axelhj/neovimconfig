local function read_tasks()
  local iter_lines =  io.lines(vim.fn.stdpath("config") .. "/tasksfile.txt")
  lines = {}
  for line in iter_lines do
    -- lines[#lines + 1] = line
    table.insert(lines, line)
  end
  return lines
end

local ok, commands = pcall(read_tasks)
if not ok then
  print"Could not read tasksfile from vim.fn.stdpath(\"config\")."
  return {}
end

local function get_cmd(map, n)
  -- Simple "fire and forget" command execution:
  -- return { map, ":OverseerRunCmd "..commands[n].."<Cr>", mode = "n" }

  -- Need to wrap in function since overseer is not available
  -- at "init" time (when spec is evaluated).
  local function run()
    require"overseer".new_task({
      cmd = { "cmd.exe" },
      args = { "/c", commands[n] },
      components = { { "on_output_quickfix", open = true }, "default" },
      strategy = "jobstart",
    }):start()
  end
  return { map, run, mode = "n" }
end

return {
  'stevearc/overseer.nvim',
  keys = {
    get_cmd("<C-3>", 1),
    get_cmd("<C-4>", 2),
    get_cmd("<C-5>", 3),
    get_cmd("<C-6>", 4),
    get_cmd("<C-7>", 5),
    get_cmd("<C-8>", 6),
    get_cmd("<C-9>", 7),
    get_cmd("<C-0>", 8),
  },
  opts = {},
}