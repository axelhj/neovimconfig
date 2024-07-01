local M = {}

function M.init_lazy()
  local lazypath = vim.fn.stdpath"data" .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)

  require("lazy").setup({
    { import = "plugins" },
  }, {
    change_detection = {
      enabled = false,
      notify = false,
    },
    git = {
      url_format = "git@github.com:%s.git",
    },
    performance = {
      -- Supposedly the very fastest mode of operation (default):
      cache = { enabled = true, },
      -- Resetting is supposedly faster (default).
      reset_packpath = true,
      -- Only include netrw(maybe), shada & editorconfig.
      rtp = {
        -- Probably try to exclude unneeded items from rtp.
        reset = true,
        -- Extra parts to rtp.
        paths = {},
        -- Disable plugins that takes time at startup but were never used.
        disabled_plugins = {
          -- "editorconfig",
          "gzip",
          "man",
          "matchit",
          "matchparen",
          "netrwPlugin", -- Prefer neotree but good to have when debugging Nvim-config.
          "nvim", -- Loads Inspect, InspectTree, EditQuery-cmds.
          "osc52",
          "rplugin",
          -- "shada",
          "spellfile",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
        },
      },
    },
  })
end

return M
