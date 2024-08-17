return {
  "orlp/vim-bunlink",
  -- Needs to be loaded lazily so that the "mru"-cache can
  -- be populated/warmed up when tabs/buffers are visisted.
  event = { "VeryLazy" },
  cmd = {
    "Bunlink",
    "Bdelete",
    "Bwipeout",
  },
}

