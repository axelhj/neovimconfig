local M = {}

function M.set_keymaps()
  local replace_termcodes = require"semiplugins.feedkeys".replace_termcodes
  local jump_window_with_wrap = require"semiplugins.windowjumpwrap".jump_window_with_wrap
  local bind_focus_next_buffer_for_direction = require"semiplugins.neotreeutils".bind_focus_next_buffer_for_direction
  local bind_for_non_neotree_buffer = require"semiplugins.neotreeutils".bind_for_non_neotree_buffer

  -- Open next file in neotree.
  vim.keymap.set("n", "<Cr>",
    function()
      if vim.bo.filetype == "qf" or vim.bo.filetype == "" then
        replace_termcodes("<Cr>", false)
      else
        replace_termcodes(":Neotree reveal<Cr>", false)
        local timer = vim.loop.new_timer()
        -- Timer is necessary because the maps are added after the popup is created
        timer:start(100, 0, vim.schedule_wrap(
          function()
            replace_termcodes("<Down><Cr>", true)
          end
        ))
      end
    end,
    {
      remap = true,
      desc = "Reveal the next file in Neotree [<Cr>]"
    }
  )

  -- Open previous file in neotree.
  vim.keymap.set("n", "<S-Cr>",
    function()
      if vim.bo.filetype == "qf" or vim.bo.filetype == "" then
        replace_termcodes("<S-Cr>", false)
      else
        replace_termcodes(":Neotree reveal<Cr>", false)
        local timer = vim.loop.new_timer()
        -- Timer is necessary because the maps are added after the popup is created
        timer:start(100, 0, vim.schedule_wrap(
          function()
            replace_termcodes("<Up><Cr>", true)
          end
        ))
      end
    end,
    {
      remap = true,
      desc = "Reveal the previous file in Neotree [<Cr>]"
    }
  )

  -- Tab, buffer & window-management related shortcuts.
  vim.keymap.set("n", "<C-S-w>", ":w<Cr>",
    { desc = "[W]rite buffer content", silent = true }
  )

  vim.keymap.set("v", "<C-S-w>", ":w<Cr>",
    { desc = "[W]rite buffer content", silent = true }
  )

  vim.keymap.set("n", "<Leader>gbn", ":enew<Cr>",
    { desc = "Edit new buffer [ gbn]", silent = true }
  )

  vim.keymap.set("n", "<Leader>gtn", ":tabnew<Cr>",
    { desc = "Add tab [ gtn]", silent = true }
  )

  vim.keymap.set("n", "<Leader>gtd", ":tabclose<Cr>",
    { desc = "Close tab [ gtd]", silent = true }
  )

  vim.keymap.set("n", "<Leader>w", ":Bunlink<Cr>",
    { desc = "Close buffer, open next and keep window (Bd) [ w]" }
  )

  vim.keymap.set("n", "<Leader>W", ":bd!<Cr>",
    { desc = "Write buffer and quit (bd!) [ W]" }
  )

  vim.keymap.set("n", "<Leader>T", ":tabclose<Cr>",
    { desc = "Close current [ T]tab" }
  )

  vim.keymap.set("n", "<Leader>q", ":qa<Cr>",
    { desc = "Close all current windows and discard changes [ q]" }
  )

  -- Toggle trouble.
  vim.keymap.set("n", "<Leader>dt",
    function() require"trouble".toggle() end,
    { desc = "Open/Close the Trouble sidebar" }
  )

  -- Lsp management.
  vim.keymap.set("n", "<Leader>-", ":LspRestart<Cr>",
    { desc = "Run LspRestart", silent = true }
  )

  -- Remaps for dealing with word wrap - kickstart.nvim.
  vim.keymap.set("n", "k", "v:count == 0 ? \"gk\" : \"k\"",
    { expr = true, silent = true }
  )
  vim.keymap.set("n", "j", "v:count == 0 ? \"gj\" : \"j'\"",
    { expr = true, silent = true }
  )

  -- Toggle terminal in current buffer.
  vim.keymap.set({ "n", "v" }, "<Leader>gtt", ":terminal<CR>",
    { silent = true, desc = "Open a terminal program in the current buffer" })

  -- Be able to leave input mode of terminal - applies with toggleterm too.
  vim.keymap.set({ "t" }, "<M-x>", "<C-\\><C-n>",
    { silent = true, desc = "Leave input mode of the open terminal" }
  )

  -- Be able to leave input mode of terminal - applies with toggleterm too.
  vim.keymap.set({ "t" }, "<C-x>", "<C-\\><C-n>",
    { silent = true, desc = "Leave input mode of the open terminal" }
  )

  -- Copy/paste related keymaps - * register.
  vim.keymap.set({ "n", "v" }, "<C-v>", "\"*p",
    { silent = true, desc = "Desktop style paste shortcut at location" }
  )

  vim.keymap.set({ "n", "v" }, "<C-S-v>", "\"*P",
    { silent = true, desc = "Desktop style paste shortcut after location" }
  )

  vim.keymap.set({ "i" }, "<C-S-v>", "<Esc>\"*pi",
    { silent = true, desc = "Desktop style paste shortcut at location" }
  )

  vim.keymap.set({ "n", "v" }, "<C-S-c>", "\"*y",
    { silent = true, desc = "Desktop style copy/yank shortcut" }
  )

  vim.keymap.set({ "n", "v" }, "<C-S-x>", "\"*d",
    { silent = true, desc = "Desktop style cut/delete shortcut" }
  )

  vim.keymap.set({ "n", "v", "i" }, "<C-1>", "5<C-y>",
    { silent = true, desc = "Scroll -5" }
  )

  vim.keymap.set({ "n", "v", "i" }, "<C-2>", "5<C-e>",
    { silent = true, desc = "Scroll +5" }
  )

  -- Quickly open init.lua. Find more config with treesitter thanks
  -- to vim-rooter.
  local lua_init_location = vim.fn.stdpath("config") .. "/init.lua"

  vim.keymap.set({ "n" }, "<C-S-i>", ":e " .. lua_init_location .. "<Cr>", {
    silent = true, desc = "Edit init.lua"
  })

  -- Switch active windows by [C-h/j/k/l]. Wrap around the edges.
  local opts = { silent = true, noremap = true, desc = "Switch window/split" }

  vim.keymap.set("n", "<C-h>", jump_window_with_wrap("h", "l"), opts)
  vim.keymap.set("n", "<C-l>", jump_window_with_wrap("l", "h"), opts)
  vim.keymap.set("n", "<C-j>", jump_window_with_wrap("j", "k"), opts)
  vim.keymap.set("n", "<C-k>", jump_window_with_wrap("k", "j"), opts)

  -- Switch buffers quickly
  vim.keymap.set("n", "<Tab>",
    bind_focus_next_buffer_for_direction(1),
    { desc = "Switch to next open buffer" }
  )

  vim.keymap.set("n", "<S-Tab>",
    bind_focus_next_buffer_for_direction(-1),
    { desc = "Switch to previous open buffer" }
  )

  vim.keymap.set("n", "<C-Tab>",
    bind_focus_next_buffer_for_direction(1),
    { desc = "Switch to next open buffer" }
  )
  vim.keymap.set("n", "<C-S-Tab>",
    bind_focus_next_buffer_for_direction(-1),
    { desc = "Switch to previous open buffer" }
  )

  vim.keymap.set("n", "gn",
    bind_focus_next_buffer_for_direction(1),
    { desc = "Switch to next open buffer" }
  )

  vim.keymap.set("n", "gp",
    bind_focus_next_buffer_for_direction(-1),
    { desc = "Switch to previous open buffer" }
  )

  vim.keymap.set( "i", "<C-Tab>",
    bind_for_non_neotree_buffer("<Esc>:BufferLineCycleNext<cr>"),
    { desc = "Switch to next open buffer" }
  )

  vim.keymap.set( "i", "<S-C-Tab>",
    bind_for_non_neotree_buffer("<Esc>:BufferLineCyclePrev<cr>"),
    { desc = "Switch to previous open buffer" }
  )
end

return M
