--[[

I hope you enjoy your Neovim journey,
- TJ

]]

require"config.options".set_options()
require"config.quickfix".set_options()

require"config.lazyinit".init_lazy()

require"config.colorscheme".set_colorscheme"bamboo-light"

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
