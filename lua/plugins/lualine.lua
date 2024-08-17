return {
  "nvim-lualine/lualine.nvim",
  event = { "VeryLazy", },
  opts = {
    options = {
      theme = "auto",
      component_separators = "|",
      section_separators = "",
    },
    sections = {
      lualine_a = {'filename'},
      lualine_b = {'mode'},
      lualine_c = {},
      lualine_x = {'branch', 'diff', 'diagnostics'},
      lualine_y = {'encoding', 'fileformat', 'filetype'},
      lualine_z = {'location'}
    },
  },
}
