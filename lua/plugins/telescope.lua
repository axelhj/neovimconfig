return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build =
        "rmdir /s /q build&"..
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release&"..
        "cmake --build build --config Release&"..
        "cmake --install build --prefix build",
      cond = function()
        return vim.fn.executable "cmake" == 1
      end,
    },
  },
  cmd = { "Telescope", },
  keys = {
    { "<Leader><Space>", mode = "n", },
    { "<Leader>fb", mode = "n", },
    { "<Leader>/", mode = "n", },
    { "<Leader>fig", mode = "n", },
    { "<Leader>fd", mode = "n", },
    { "<Leader>ff", mode = "n", },
    { "<Leader>fg", mode = "n", },
    { "<Leader>fh", mode = "n", },
    { "<Leader>fl", mode = "n", },
    { "<Leader>fL", mode = "n", },
    { "<Leader>fs", mode = "n", },
    { "<Leader>fw", mode = "n", },
    { "<Leader>r", mode = "n", },
    { "<Leader>s", mode = "n", },
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-F",
        "-u",
        "-u",
        "--glob=!**/node_modules/**/*",
        "--glob=!**/.git/**/*",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--case-sensitive"
      },
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
        },
      },
    },
  },
  config = function(spec)
    require("telescope").setup(spec.opts)
    local ok = pcall(require("telescope").load_extension, "fzf")
    if not ok then print("Loading Telescope FZF-ext failed") end
    vim.keymap.set("n", "<Leader>fo", require("telescope.builtin").oldfiles, { desc = "[f]ind recently [o]pened (old-)files" })
    vim.keymap.set("n", "<Leader>ff", require("telescope.builtin").oldfiles, { desc = "[f]ind recently opened [f]iles" })
    vim.keymap.set("n", "<Leader>fb", require("telescope.builtin").buffers, { desc = "[f]ind existing [b]uffers" })
    vim.keymap.set("n", "<Leader>/", function()
      require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = "Fuzzily search in current buffer [<Leader>/]" })
    vim.keymap.set("n", "<Leader>fig", require("telescope.builtin").git_files, { desc = "[f]ind in [g]it [f]iles" })
    vim.keymap.set("n", "<Leader><Space>", require("telescope.builtin").find_files, { desc = "[ ][ ] fuzzy find files" })
    vim.keymap.set("n", "<Leader>fh", require("telescope.builtin").help_tags, { desc = "[f]ind [h]elp" })
    vim.keymap.set("n", "<Leader>fH", require("telescope.builtin").highlights, { desc = "[f]ind [H]highlights" })
    vim.keymap.set("n", "<Leader>fw", require("telescope.builtin").grep_string, { desc = "[f]ind current [w]ord" })
    -- Needs different search options to accept grep/re syntax:
    vim.keymap.set("n", "<Leader>fg", require("telescope.builtin").live_grep, { desc = "[f]ind - search by [g]rep" })
    vim.keymap.set("n", "<Leader>fd", require("telescope.builtin").diagnostics, { desc = "[f]ind [d]iagnostics" })
    vim.keymap.set("n", "<Leader>r", require("telescope.builtin").resume, { desc = "search - [r]esume" })
    vim.keymap.set("n", "<Leader>s", require("telescope.builtin").live_grep, { desc = "[s]earch string" })
    -- This does not actually appear to exist. grep_string is not really applicable here. Needs custom helper func.
    -- vim.keymap.set("v", "<Leader>fv", require("telescope.builtin").grep_string, { desc = "[f]ind content of [v]isual selection" })
    -- (Mapped to vim-grep/rg and qf/:copen instead in the quickfix.lua config).
    -- "<Leader>fr" is mapped to find LSP references in telescope.
  end
}
