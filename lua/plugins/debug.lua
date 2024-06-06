return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "nvim-neotest/nvim-nio",
    -- Add your own debuggers here
    -- "leoluz/nvim-dap-go",
  },
  -- Lazy-init
  keys = {
    { "<F5>", mode = "n" },
    { "<F7>", mode = "n" },
    { "<F9>", mode = "n" },
    { "<Leader>bb", mode = "n" },
    { "<Leader>B", mode = "n" },
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    require("dap-python").setup("python")
    require("dap-python").resolve_python = function()
      return "C:/msys64/usr/bin/python.exe"
    end

    -- Basic debugging keymaps.
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<S-F11>", dap.step_out, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<S-F5>", dap.close, { desc = "Debug: Stop" })
    vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
    end, { desc = "Debug: Set Breakpoint" })

    -- Dap UI setup
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
      controls = {
        icons = {
          pause = "⏸",
          play = "▶",
          step_into = "⏎",
          step_over = "⏭",
          step_out = "⏮",
          step_back = "b",
          run_last = "▶▶",
          terminate = "⏹",
          disconnect = "⏏",
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set("n", "<F7>",
      function()
        dapui.toggle()
        require"semiplugins.neotreeutils".resize()
      end,
      { desc = "Debug: See last session result [F7]" }
    )

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close
    dap.listeners.after.event_terminated["dapui_config"] = require"semiplugins.neotreeutils".resize
    dap.listeners.after.event_exited["dapui_config"] = require"semiplugins.neotreeutils".resize

    -- dap.defaults.fallback.exception_breakpoints = { "Notice", "Warning", "Error", "Exception" }
    dap.defaults.cs.exception_breakpoints = { "all", "user-unhandled" }

    -- Install golang specific config
    -- require("dap-go").setup()
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = "OpenDebugAD7",
      options = {
        detached = false
      }
    }
    dap.adapters.netcoredbg = {
      type = "executable",
      command = "netcoredbg.exe",
      args = {"--interpreter=vscode"},
    }
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          local exe = io.popen("find . -maxdepth 2 -path \"*build*\" -name *.exe")
          if not exe then return end
          return (vim.fn.getcwd() .. "\\" .. exe:lines()()):gsub("/", "\\")
        end,
        externalConsole = true,
        cwd = "${workspaceFolder}/build",
        stopAtEntry = false,
        MIMode = "gdb",
        MIDebuggerPath = vim.fn.exepath("gdb"),
      },
      {
        name = "Attach to gdbserver :1234",
        type = "cppdbg",
        request = "launch",
        miDebuggerServerAddress = "localhost:1234",
        MIDebuggerPath = vim.fn.exepath("gdb"),
        MIMode = "gdb",
        program = function()
          local exe = io.popen("find . -maxdepth 1 -type d -path \"build/**/*.exe\" -printf \"%p\\n\"")
          if not exe then return end
          return (vim.fn.getcwd() .. "/" .. exe:lines()()):gsub("/", "\\")
        end,
        externalConsole = true,
        cwd = "${workspaceFolder}",
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.adapters.coreclr = {
      type = "executable",
      command = "netcoredbg",
      args = {"--interpreter=vscode"}
    }
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          local dll = io.popen("find . -maxdepth 3 -name \"*.dll\"")
          if not dll then return end
          return (vim.fn.getcwd() .. "/" .. dll:lines()()):gsub("/", "\\")
        end,
        cwd = function()
          local path = io.popen("find . -maxdepth 1 -type d -path \"bin/**/*.dll\" -printf \"%p\\n\"")
          if not path then return end
          return (vim.fn.getcwd() .. "/" .. path:lines()()):gsub("/", "\\")
        end,
        env = {
          ASPNETCORE_ENVIRONMENT = "Development",
        },
      },
    }
  end,
}
