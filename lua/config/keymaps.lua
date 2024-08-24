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
        replace_termcodes("<Cmd>Neotree reveal<Cr>", false)
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
        replace_termcodes("<Cmd>Neotree reveal<Cr>", false)
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
  vim.keymap.set("n", "<C-S-w>", "<Cmd>w<Cr>",
    { desc = "[W]rite buffer content", silent = true }
  )

  vim.keymap.set("n", "<M-w>", "<Cmd>w<Cr>",
    { desc = "[W]rite buffer content", silent = true }
  )

  vim.keymap.set("v", "<C-S-w>", "<Cmd>w<Cr>",
    { desc = "[W]rite buffer content", silent = true }
  )

  vim.keymap.set("v", "<M-w>", "<Cmd>w<Cr>",
    { desc = "[W]rite buffer content", silent = true }
  )

  vim.keymap.set("i", "<M-w>", "<Cmd>w<Cr><Esc>",
    { desc = "[W]rite buffer content", silent = true }
  )

  vim.keymap.set("n", "<Leader>gbn", "<Cmd>enew<Cr>",
    { desc = "Edit new buffer [ gbn]", silent = true }
  )

  vim.keymap.set("n", "<Leader>gtn", "<Cmd>tabnew<Cr>",
    { desc = "Add tab [ gtn]", silent = true }
  )

  vim.keymap.set("n", "<Leader>gtd", "<Cmd>tabclose<Cr>",
    { desc = "Close tab [ gtd]", silent = true }
  )

  vim.keymap.set("n", "<Leader>w", "<Cmd>Bunlink<Cr>",
    { desc = "Close buffer, open next and keep window (Bu) [ w]" }
  )

  vim.keymap.set("n", "<Leader>W", "<Cmd>Bunlink!<Cr>",
    { desc = "Close  and discard buffer, open next and keep window (:Bu!) [ W]" }
  )

  vim.keymap.set("n", "vx", "<Cmd>Bunlink!<Cr>",
    { desc = "Close  and discard buffer, open next and keep window (:Bu!) [ W]" }
  )

  vim.keymap.set("n", "<Leader>T", "<Cmd>tabclose<Cr>",
    { desc = "Close current [ T]tab" }
  )

  vim.keymap.set("n", "<Leader>q", "<Cmd>SaveSessionAndQuitNeovim<Cr>",
    { desc = "Quit Neovim pending session-save (quit) [ q]" }
  )

  vim.keymap.set("n", "<Leader>Q", "<Cmd>qa<Cr>",
    { desc = "Quit Neovim with NO session-save (quit) [ Q]" }
  )

  -- Escape hatch; cancel shutdown within timeout opt by overriding
  -- with escape- or q-key.
  vim.keymap.set("n", "<Leader>q<Esc>", "<Cmd>silent echo <Cr>",
    { desc = "Abort close all current windows (quit) [ q<Esc>]" }
  )
  vim.keymap.set("n", "<Leader>qq", "<Cmd>silent echo \"Do nothing\"<Cr>",
    { desc = "Abort close all current windows (quit) [ qq]" }
  )
  vim.keymap.set("n", "<Leader>Q<Esc>", "<Cmd>silent echo <Cr>",
    { desc = "Abort close all current windows (quit) [ Q<Esc>]" }
  )
  vim.keymap.set("n", "<Leader>QQ", "<Cmd>silent echo \"Do nothing\"<Cr>",
    { desc = "Abort close all current windows (quit) [ QQ]" }
  )

  -- Lsp management.
  vim.keymap.set("n", "<Leader>-", "<Cmd>LspRestart<Cr>",
    { desc = "Run LspRestart", silent = true }
  )

  -- Remaps for dealing with word wrap - kickstart.nvim.
  vim.keymap.set("n", "k", "v:count == 0 ? \"gk\" : \"k\"",
    { expr = true, silent = true }
  )
  vim.keymap.set("n", "j", "v:count == 0 ? \"gj\" : \"j'\"",
    { expr = true, silent = true }
  )

  -- Open terminal in current buffer.
  vim.keymap.set({ "n", "v" }, "<Leader>gtt", "<Cmd>terminal<CR>",
    { silent = true, desc = "Open a terminal program in the current buffer" })

  -- Be able to leave input mode of terminal - applies with toggleterm too.
  vim.keymap.set({ "t" }, "<M-x>", "<C-\\><C-n>",
    { silent = true, desc = "Leave input mode of the open terminal" }
  )

  -- Be able to leave input mode of terminal - applies with toggleterm too.
  vim.keymap.set({ "t" }, "<C-x>", "<C-\\><C-n>",
    { silent = true, desc = "Leave input mode of the open terminal" }
  )

  -- Cut/copy/paste related keymaps - * register.
  vim.keymap.set({ "n", "v" }, "<M-v>", "\"*P",
    { silent = true, desc = "Desktop style paste shortcut after location" }
  )

  vim.keymap.set({ "n", "v" }, "<M-S-v>", "\"*p",
    { silent = true, desc = "Desktop style paste shortcut at location" }
  )

  vim.keymap.set({ "i" }, "<M-v>", "<Esc>\"*pi",
    { silent = true, desc = "Desktop style paste shortcut at location" }
  )

  vim.keymap.set({ "n", "v" }, "<M-c>", "\"*y",
    { silent = true, desc = "Visual/motion yank/copy to clipboard shortcut" }
  )

  vim.keymap.set({ "n", "v" }, "<M-x>", "\"*d",
    { silent = true, desc = "Visual/motion delete/cut to clipboard shortcut" }
  )

  -- Multi-line scroll mappings.
  vim.keymap.set({ "n", "v", "i" }, "<C-1>", "5<C-y>",
    { silent = true, desc = "Scroll -5" }
  )

  vim.keymap.set({ "n", "v", "i" }, "<M-1>", "5<C-y>",
    { silent = true, desc = "Scroll -5" }
  )

  vim.keymap.set({ "n", "v", "i" }, "<C-2>", "5<C-e>",
    { silent = true, desc = "Scroll +5" }
  )

  vim.keymap.set({ "n", "v", "i" }, "<M-2>", "5<C-e>",
    { silent = true, desc = "Scroll +5" }
  )

  -- Quickly open init.lua. Find more config with treesitter thanks
  -- to vim-rooter.
  local lua_init_location = vim.fn.stdpath("config") .. "/init.lua"

  vim.keymap.set({ "n" }, "<C-S-e>1", "<Cmd>e " .. lua_init_location .. "<Cr>", {
    silent = true, desc = "Edit init.lua"
  })

  vim.keymap.set({ "n" }, "<M-e>1", "<Cmd>e " .. lua_init_location .. "<Cr>", {
    silent = true, desc = "Edit init.lua"
  })

  -- Switch active windows by [C-h/j/k/l or M-h/j/k/l]. Wrap around the edges.
  local opts = { silent = true, noremap = true, desc = "Switch window/split" }

  vim.keymap.set("n", "<C-h>", jump_window_with_wrap("h", "l"), opts)
  vim.keymap.set("n", "<M-h>", jump_window_with_wrap("h", "l"), opts)
  vim.keymap.set("n", "<C-l>", jump_window_with_wrap("l", "h"), opts)
  vim.keymap.set("n", "<M-l>", jump_window_with_wrap("l", "h"), opts)
  vim.keymap.set("n", "<C-j>", jump_window_with_wrap("j", "k"), opts)
  vim.keymap.set("n", "<M-j>", jump_window_with_wrap("j", "k"), opts)
  vim.keymap.set("n", "<C-k>", jump_window_with_wrap("k", "j"), opts)
  vim.keymap.set("n", "<M-k>", jump_window_with_wrap("k", "j"), opts)

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

  vim.keymap.set("n", "<M-Tab>",
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

  vim.keymap.set("i", "<C-Tab>",
    bind_for_non_neotree_buffer("<Esc><Cmd>BufferLineCycleNext<Cr>"),
    { desc = "Switch to next open buffer" }
  )

  vim.keymap.set("i", "<S-C-Tab>",
    bind_for_non_neotree_buffer("<Esc><Cmd>BufferLineCyclePrev<Cr>"),
    { desc = "Switch to previous open buffer" }
  )

  vim.keymap.set("i", "<M-Tab>",
    bind_for_non_neotree_buffer("<Esc><Cmd>BufferLineCyclePrev<Cr>"),
    { desc = "Switch to previous open buffer" }
  )

  vim.keymap.set("n", "<Leader>gl", "<Cmd>tabnew<Cr><Cmd>terminal lazygit<Cr>i",
    { desc = "Open lazyvim in new tab" }
  )
end

return M
