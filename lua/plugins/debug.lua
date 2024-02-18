-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'mfussenegger/nvim-dap-python',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('dap-python').setup('python')
    require('dap-python').resolve_python = function()
      return 'C:/msys64/usr/bin/python.exe'
    end

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<S-F11>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<S-F5>', dap.close, { desc = 'Debug: Stop' })
    vim.keymap.set('n', '<leader>bb', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>',
      function()
        dapui.toggle()
        require'neotreenormalized'.resize()
      end,
      { desc = 'Debug: See last session result [F7]' }
    )

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
    dap.listeners.after.event_terminated['dapui_config'] = require'neotreenormalized'.resize
    dap.listeners.after.event_exited['dapui_config'] = require'neotreenormalized'.resize

    -- dap.defaults.fallback.exception_breakpoints = { "Notice", "Warning", "Error", "Exception" }
    dap.defaults.cs.exception_breakpoints = { "all", "user-unhandled" }

    -- Install golang specific config
    -- require('dap-go').setup()
    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = 'OpenDebugAD7',
      options = {
        detached = false
      }
    }
    dap.adapters.netcoredbg = {
      type = 'executable',
      command = 'netcoredbg.exe',
      args = {'--interpreter=vscode'},
    }
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input{'Path to executable: ', vim.fn.getcwd() .. '/', 'file'}
        end,
        externalConsole = true,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        MIMode = "gdb",
        MIDebuggerPath = vim.fn.exepath('gdb'),
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        miDebuggerServerAddress = 'localhost:1234',
        MIDebuggerPath = vim.fn.exepath('gdb'),
        MIMode = "gdb",
        program = function()
          return vim.fn.input({'Path to executable: ', vim.fn.getcwd() .. '/', 'file'})
        end,
        externalConsole = true,
        cwd = '${workspaceFolder}',
      },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.adapters.coreclr = {
      type = 'executable',
      command = 'netcoredbg',
      args = {'--interpreter=vscode'}
    }
    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          local dll = io.popen("find . -maxdepth 3 -name \"*.dll\"")
          return (vim.fn.getcwd() .. "/" .. dll:lines()()):gsub("/", "\\")
        end,
        cwd = function()
          local path = io.popen("find . -maxdepth 1 -type d -path \"bin/**/*.dll\" -printf \"%p\\n\"")
          return (vim.fn.getcwd() .. "/" .. path:lines()()):gsub("/", "\\")
        end,
        env = {
          ASPNETCORE_ENVIRONMENT = 'Development',
        },
      },
    }
  end,
}
