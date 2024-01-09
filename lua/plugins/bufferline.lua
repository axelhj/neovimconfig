return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = true,
  opts =  {
    options = {
      middle_mouse_command = function(bufnum)
        local is_active = vim.fn.getbufinfo(bufnum)[1].loaded == 1
        local is_hidden = vim.fn.getbufinfo(bufnum)[1].hidden == 1
        if not is_active or is_hidden then
          vim.api.nvim_command(":bdelete " .. bufnum)
        else
          vim.api.nvim_command(":Bunlink")
        end
      end,
      right_mouse_command = function(bufnum)
        local is_active = vim.fn.getbufinfo(bufnum)[1].loaded == 1
        local is_hidden = vim.fn.getbufinfo(bufnum)[1].hidden == 1
        if not is_active or is_hidden then
          vim.api.nvim_command(":bdelete " .. bufnum)
        else
          vim.api.nvim_command(":Bunlink")
        end
      end,
      custom_filter = function(buf_number--[[, buf_numbers]])
        -- filter out filetypes you don't want to see
        return vim.bo[buf_number].filetype ~= "quickfix" and
          vim.bo[buf_number].buftype ~= "terminal" and
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
          return buffer_a.name < buffer_b.name
        end
        return buffer_a.extension < buffer_b.extension
      end,
      tab_size = 11,
      truncate_names = true,
      max_name_length = 36,
    },
  },
}
