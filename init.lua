--[[

I hope you enjoy your Neovim journey,
- TJ

--]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require"defaults"

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',
  { 'folke/which-key.nvim', opts = {} },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
        local gs = package.loaded.gitsigns
        vim.keymap.set({'n', 'v'}, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})
        vim.keymap.set({'n', 'v'}, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})
      end,
    },
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    tag = "v2.20.8",
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },
  -- "gc" or "Ctrl+," to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
        line = '<C-,>',
      },
    },
    keys = {
      { '<C-,>',
        'gc',
        mode = 'n',
        desc = "Toggle comment with Comment.nvim"
      },
      {
        'gcc',
        mode = 'n', 'v',
        desc = "Toggle comment with Comment.nvim"
      },
      {
        'gbc',
        mode = 'n',
        desc = "Toggle block comment with Comment.nvim (motions)"
      },
      {
        'gc',
        mode = 'n',
        desc = "Toggle comment with Comment.nvim (motions)"
      },
      {
        'gb',
        mode = 'n',
        desc = "Toggle block comment with Comment.nvim (motions)"
      },
    },
  },
  -- Shim to help with gui font & transparency commands in nvim.
  "equalsraf/neovim-gui-shim",
  { import = 'custom.plugins' },
}, {})

require("lazy").setup("plugins", {
  change_detection = {
    enabled = false,
    notify = false,
  },
})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
  desc = 'Go to previous diagnostic message'
})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
  desc = 'Go to next diagnostic message'
})
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, {
  desc = 'Open floating diagnostic message'
})
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
  desc = 'Open diagnostics list'
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
