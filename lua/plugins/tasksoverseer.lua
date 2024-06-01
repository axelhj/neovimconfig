local function read_tasks()
  local iter_lines =  io.lines(vim.fn.stdpath("config") .. "/tasksfile.txt")
  local lines = {}
  for line in iter_lines do
    -- lines[#lines + 1] = line
    table.insert(lines, line)
  end
  return lines
end

local function try_read_tasks()
  local ok, commands = pcall(read_tasks)
  if ok then
    return commands
  end
  print"Could not read tasksfile.txt from vim.fn.stdpath(\"config\")."
end

local function get_cmd(map, n)
  -- Simple "fire and forget" command execution:
  -- return { map, ":OverseerRunCmd "..commands[n].."<Cr>", mode = "n" }

  -- Need to wrap in function since overseer is not available
  -- at "init" time (when spec is evaluated).
  local function run()
    local commands = try_read_tasks()
    if commands == nil then return end
    require"overseer".new_task({
      cmd = { "cmd.exe" },
      name = "shell " .. n,
      args = { "/c", commands[n] },
      components = {
        "on_exit_set_status",
      },
      strategy = {
        "toggleterm",
        auto_scroll = true,
        cwd = vim.api.nvim_command"pwd",
        on_create = function(term)
          vim.api.nvim_buf_set_name(term.bufnr, "overseer_term_"..term.bufnr)
        end,
      },
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
    get_cmd("m3", 1),
    get_cmd("m4", 2),
    get_cmd("m5", 3),
    get_cmd("m6", 4),
    get_cmd("m7", 5),
    get_cmd("m8", 6),
    get_cmd("m9", 7),
    get_cmd("m0", 8),
  },
  opts = {},
}
