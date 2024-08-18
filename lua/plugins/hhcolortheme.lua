local ibl_hook_id = nil

local function clear_ibl_hook()
  local hooks = require "ibl.hooks"
  if ibl_hook_id ~= nil then
    hooks.clear(ibl_hook_id)
    ibl_hook_id = nil
  end
end

local function register_ibl_hook()
  local hooks = require "ibl.hooks"
  clear_ibl_hook()
  ibl_hook_id = hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    require("plugins.hhcolortheme").set_custom_highlights()
    clear_ibl_hook()
  end)
end

return {
  "hardhackerlabs/theme-vim",
  name = "hardhacker",
  config = function()
    vim.cmd[[
      " mask tilde and use italics
      let g:hardhacker_hide_tilde = 1
      let g:hardhacker_keyword_italic = 1
      " skip monochrome bufferline theme colors
      let g:skip_bufferline_theme = 0
      " custom highlights
      let g:hardhacker_custom_highlights = []
      " enable plugin
      syntax      enable
      syntax      on
      set         t_Co=256
    ]]
    vim.api.nvim_create_augroup("hh_colorschemeheme_augroup", { clear = true })
    vim.api.nvim_create_autocmd({ "ColorScheme" }, {
      pattern = "hardhacker",
      callback = function()
        vim.cmd"HardHackerAfterHighlight"
        register_ibl_hook()
        require("plugins.hhcolortheme").set_custom_highlights()
        local ibl = require"plugins.indentblankline"
        require"ibl".setup(ibl.opts)
        vim.cmd"highlight! link Comment HardHackerComment"
      end,
      group = "hh_colorschemeheme_augroup"
    })
  end,
  activate = function()
    vim.cmd"colorscheme hardhacker"
  end,
  set_custom_highlights = function()
    -- Customize indent guide colors.
    vim.api.nvim_set_hl(0, "IndentGuideBgAlt1", {
      bg = "#282433", -- Match Normal-bg
      fg = "#303030", -- Regular fg
    })
    vim.api.nvim_set_hl(0, "IndentGuideBgAlt2", {
      bg = "#24202e", -- Slightly darker Normal-bg
      fg = "#303030", -- Alternate fg
    })
    -- Used by listchars + list
    vim.api.nvim_set_hl(0, "NonText", {
      fg = "#404040",
    })
    vim.api.nvim_set_hl(0, "SpecialText", {
      fg = "#404040",
    })
  end,
}
