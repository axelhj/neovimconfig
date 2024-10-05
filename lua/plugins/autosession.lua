return {
  "axelhj/auto-session",
  dependencies = { "nvimdev/hlsearch.nvim", },
  event = { "VeryLazy", },
  config = function(spec)
    require"auto-session".setup(spec.opts)
    -- The plugin will normally restore at UIEnter
    -- but when lazy-loaded that has already happened.
    vim.cmd("RestoreSession")
  end,
  opts = {
    shada = '!,\'100'
  },
}
