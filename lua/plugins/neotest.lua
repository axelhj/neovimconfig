return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "Issafalcon/neotest-dotnet",
  },
  cmd = {
    "Neotest"
  },
  keys = {
    {
      "<Leader>etd", function() require("neotest").run.run({strategy = "dap"}) end,
      mode = "n",
      desc = "[e]exec [t]ests, [d]ebug with neotest"
    }, {
      "<Leader>ete", function() require("neotest").run.run() end,
      mode = "n",
      desc = "[e]xec [t][e]sts with neotest"
    }, {
      "<Leader>eft", function() require("neotest").run.run(vim.fn.expand("%")) end,
      mode = "n",
      desc = "for [e]ach test in [f]ile, [t]test with neotest"
    }, {
      "<Leader>efd", function()
        require("neotest").run.run({
          vim.fn.expand("%"),
          strategy = "dap"
        })
      end,
      mode = "n",
      desc = "for [e]ach test in [f]ile, [d]ebug with neotest"
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        -- require("neotest-python")({
        --   dap = { justMyCode = false },
        -- }),
        -- require("neotest-plenary"),
        -- require("neotest-vim-test")({
        --   ignore_file_types = { "python", "vim", "lua" },
        -- }),
        require("neotest-dotnet"),
      },
    })
  end,
}
