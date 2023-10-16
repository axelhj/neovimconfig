return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = true,
  opts =  {
    options = {
      middle_mouse_command = "bdelete %d",
      right_mouse_command = "bdelete %d",
      custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        return vim.bo[buf_number].filetype ~= "quickfix" and
          vim.fn.bufname(buf_number) ~= ""
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "b:",
          text_align = "right",
          separator = true,
        },
      },
      separator_style = "slant",
      sort_by = function(buffer_a, buffer_b)
        if (buffer_a.extension == buffer_b.extension) then
          return buffer_a.id < buffer_b.id
        end
        return buffer_a.extension < buffer_b.extension
      end,
    },
  },
}
