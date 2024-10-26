return {
  "SGauvin/ctest-telescope.nvim",
  opts = {
    -- extra_ctest_args = { ".\build\test\testproj.exe", },
    -- build_folder = ".\build\test",
    dap_config = {
      type = "cppdbg",
      request = "launch",
      -- stopAtEntry = true,
    },
  },
  config = function(spec)
    require("ctest-telescope").setup(spec.opts)
    vim.keymap.set("n", "<Leader>etl", function()
      local dap = require("dap")
      if dap.session() == nil and (vim.bo.filetype == "cpp" or vim.bo.filetype == "c") then
        -- Only call this on C++ and C files
        require("ctest-telescope").pick_test_and_debug()
      else
        dap.continue()
      end
    end, { desc = "Debug: Start/Continue" })
  end,
}
