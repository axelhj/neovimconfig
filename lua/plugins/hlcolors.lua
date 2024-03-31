--[[
local options = {
  -- hex codes
  RRGGBBAA = false;
  -- rgb() and rgba() funcs
  rgb_fn = false;
  -- hsl() funcs
  hsl_fn = false;
  -- CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css = true;
  -- CSS "function features"
  css_fn = true;
}
]]--

return {
  "brenoprata10/nvim-highlight-colors",
  event = "VeryLazy",
  opts = {
    -- also foreground or first_column
    render = "background";
    enable_named_colors = true;
    enable_tailwind = true;
    -- css = options;
    -- scss = options;
    -- html = {
      -- mode = "foreground";
    -- },
  },
}
