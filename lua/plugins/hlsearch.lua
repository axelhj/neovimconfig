return {
  "nvimdev/hlsearch.nvim",
  event = { "VeryLazy", },
  config = function()
    -- This plugin will only be activated for buffers that got
    -- loaded after the BufWinEnter event was configured.
    -- Lazy-loading it will work if it loads before the auto-session
    -- plugin so that one lists this one as a dependency.
    require"hlsearch".setup()
  end,
}
