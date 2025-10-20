local is_win = require("semiplugins.iswin").is_win()

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
    if commands[n] == nil then
      print"Items missing in tasksfile.txt from vim.fn.stdpath(\"config\")."
      return
    end
    require"overseer".new_task({
      cmd = { is_win and "cmd.exe" or "bash" },
      name = "shell " .. n,
      args = is_win and
        { "/c", commands[n] } or
        { "-c", "\""..commands[n].."\"" },
      components = {
        "on_exit_set_status",
      },
      strategy = {
        "toggleterm",
        auto_scroll = true,
        cwd = vim.api.nvim_command"pwd",
        direction = require"plugins.toggleterm".opts.direction,
        start_in_insert = true,
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
  tag="v1.6.0",
  keys = {
    get_cmd("<C-1>", 1),
    get_cmd("<C-2>", 2),
    get_cmd("<C-3>", 3),
    get_cmd("<C-4>", 4),
    get_cmd("<C-5>", 5),
    get_cmd("<C-6>", 6),
    get_cmd("<C-7>", 7),
    get_cmd("<C-8>", 8),
    get_cmd("<C-9>", 9),
    get_cmd("<C-0>", 10),
    get_cmd("<M-1>", 1),
    get_cmd("<M-2>", 2),
    get_cmd("<M-3>", 3),
    get_cmd("<M-4>", 4),
    get_cmd("<M-5>", 5),
    get_cmd("<M-6>", 6),
    get_cmd("<M-7>", 7),
    get_cmd("<M-8>", 8),
    get_cmd("<M-9>", 9),
    get_cmd("<M-0>", 10),
  },
  opts = {},
}
