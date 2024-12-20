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
    require("plugins.bamboocolortheme").set_custom_highlights()
    clear_ibl_hook()
  end)
end

return {
  "ribru17/bamboo.nvim",
  config = function()
    require("bamboo").load()
    require("bamboo").setup{ style = "light" }
    vim.api.nvim_create_augroup("bamboo_colorscheme_augroup", { clear = true })
    vim.api.nvim_create_autocmd({ "ColorScheme" }, {
      pattern = "bamboo-light",
      callback = function()
        register_ibl_hook()
        require("plugins.bamboocolortheme").set_custom_highlights()
        local ibl = require"plugins.indentblankline"
        require"ibl".setup(ibl.opts)
      end,
      group = "bamboo_colorscheme_augroup"
    })
  end,
  activate = function()
    vim.cmd"colorscheme bamboo-light"
  end,
  set_custom_highlights = function()
    -- Customize indent guide colors.
    vim.api.nvim_set_hl(0, "IndentGuideBgAlt1", {
      bg = "#fafae0", -- Match Normal-bg
      fg = "#dadac2", -- Regular fg
    })
    vim.api.nvim_set_hl(0, "IndentGuideBgAlt2", {
      bg = "#eaead0", -- Slightly darker Normal-bg
      fg = "#dadac2", -- Alternate fg
    })
    -- Used by listchars + list
    vim.api.nvim_set_hl(0, "NonText", {
      fg = "#dadac2",
    })
    vim.api.nvim_set_hl(0, "SpecialText", {
      fg = "#dadac2",
    })
    -- This applies to bufferline non-active tab aswell
    -- as any source code comments. Contrast is improved slightly.
    -- Apparently also used with object literals in lua.
    vim.api.nvim_set_hl(0, "Comment", {
      fg = "#6f4c05",
    })
  end,
}
--[[
asdcontrast = "#fff8f0",
    inverse = "#000000",
    bg0 = "#fafae0",
    bg1 = "#eaead0",
    bg2 = "#e4e4cc",
    bg3 = "#dadac2",
    bg_d = "#c7c7af",
    bg_blue = "#589ed8",
    bg_yellow = "#6f4c05",
    fg = "#3a4238",
    purple = "#8a4adf",
    bright_purple = "#c810d0",
    green = "#27850b",
    orange = "#df5926",
    blue = "#1745d5",
    light_blue = "#177fff",
    yellow = "#a77b00",
    cyan = "#188a9e",
    red = "#c72a3c",
    coral = "#c05050",
    grey = "#a1a7a0",
    light_grey = "#838781",
    diff_add = "#c0e3ab",
    diff_delete = "#f9afb5",
    diff_change = "#d2dceb",
    diff_text = "#c2ccdb",
  },
}
]]
