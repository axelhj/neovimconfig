M = {}

function M.set_options()
  -- Setup leader key. Invoke before plugins are loaded.
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- Set highlight on search
  vim.o.hlsearch = true
  vim.o.incsearch = true

  -- Switch to new split - left and right
  vim.o.splitright = true
  vim.o.splitbelow = true

  -- Make line numbers default
  vim.o.number = true

  -- Enable mouse mode
  vim.o.mouse = "a"

  -- Sync clipboard between OS and Neovim.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help "clipboard"`
  vim.o.clipboard = ""

  -- Enable break-indent - indent autowrapped line-continuations.
  vim.o.breakindent = true

  -- Auto indent when a new line is opened.
  vim.o.autoindent = true

  -- Don't preserve broken indent - stick to multiples rather than incorporate
  -- broken (non-divisible by eg. 4) indentation on following lines:
  vim.o.shiftround = true

  -- Do NOT mix tabs and spaces in a weird flurry.
  vim.o.expandtab = true

  -- Use shiftwidth for C-indent if enabled.
  vim.o.cinoptions = "1s"

  -- Disable wonky Neovim indent. Double-indents following {
  -- if using "cc" (change line)
  vim.o.indentexpr = ""

  -- Python ft config really messes up indenting badly - indenting
  -- follow-on indents by multiples.
  vim.g.pyindent_open_paren = "&sw"
  vim.g.pyindent_nested_paren = "&sw"
  vim.g.pyindent_continue = "&sw"

  -- Save undo history
  vim.o.undofile = true

  -- Case-sensitive searching
  vim.o.ignorecase = false
  vim.o.smartcase = false

  -- Keep signcolumn on by default
  vim.wo.signcolumn = "yes"
  vim.go.signcolumn = "yes"
  vim.o.signcolumn = "yes"

  -- Set updatetime - swapfile writing
  -- and CursorHold events timeout (ms).
  vim.o.updatetime = 75

  -- Timeout after waiting for certain inputs.
  vim.o.timeoutlen = 1750

  -- Set completeopt to nothing to avoid completions popping up on screen.
  -- Also disable <C-n> and <C-p> insert mappings to let nvim-cmp handle that.
  vim.o.completeopt = ""

  -- NOTE: You should make sure your terminal supports this
  vim.o.termguicolors = true
  vim.go.termguicolors = true

  -- Keymaps for better default experience - kickstart.nvim
  -- See `:help vim.keymap.set()`
  vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

  -- Don't wrap around to the start/end once end/start is
  -- reached in search.
  vim.o.wrapscan = false

  -- Softwrap long lines, linebreak by word.
  vim.o.textwidth = 0
  vim.o.wrapmargin = 0
  vim.o.wrap = true
  vim.o.linebreak = true

  -- Messages:
  -- A: Make the "file open in other session" warning
  --   less intrusive/frequent
  -- I: Eliminate vim startup wall of text
  -- c: Remove/omit messages about completion matches in the
  --    commandbar/win.
  -- F: Skip annoying fileinfo when files are open. Display
  --    similar info by pressing <C-g> in normal mode instead.
  -- W: Skip "written"/[w] notice when file was written.
  -- s: Supposed to skip message about "search hit bottom"/top
  --    but it does not work (does not remove E385/E385 is displayed).
  --    seems to interact with cmdheight=0 or laststatus=0.
  -- S: Supposed to skip search I/J number message during search
  --    which it does. Does not remove E385.
  -- t: Truncate messages as start (not at middle like T) so
  --    that the "Press return"-prompt will go away and never
  --    come back.
  vim.o.shortmess="AIcFWSst"

  -- Useful font config - installed from nerdfonts.com

  if vim.g.neovide then
    vim.g.neovide_scroll_animation_length=0.05
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animation_length = 0
    vim.cmd"nnoremap <M-Cr> <Cmd>let g:neovide_fullscreen = g:neovide_fullscreen == v:false<Cr>"
    vim.keymap.set({ "n", "v" }, "<C-ScrollWheelUp>", "<Cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
    vim.keymap.set({ "n", "v" }, "<C-ScrollWheelDown>", "<Cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  elseif vim.g.nvy then
    vim.o.guifont = "IntoneMono NFM:h7"
  else
    vim.o.guifont = "IntoneMono NFM:h9"
  end

  -- Setting that is useful for sending proper path separators to netcoredbg.
  vim.o.shellslash = false

  -- Keep some context visible at top and bottom. Absolute linecount,
  -- context visible for j/k scrolling.
  vim.o.scrolloff = 4

  -- Context visible for jump/search scrolling. Appears to apply for j/k
  -- scrolling too. Absolute number or percentage linecount with -n works too.
  vim.o.scrolljump = 1

  -- Horizontal scrolloff if nowrap is set/wrap is disabled. Absolute linecount.
  vim.o.sidescrolloff = 6

  -- signcolumn - show breakpoint column [auto, auto:[1-9], auto:[1-8:2-9], no, yes, yes:[1-9, number]
  -- Numner/range sets maximum or min-maximum
  vim.o.signcolumn = "yes:2"

  -- Deal with transparency - make nvim-qt look more interesting.
  if vim.v.vim_did_enter == 1 then
    vim.cmd "GuiWindowOpacity 0.975"
  end

  -- Do not comment line following comment on <Cr>, <C-o>
  vim.opt.formatoptions:remove { "c", "r", "o" }

  -- Workaround because some Nvim ftplugin:s messes with the formatoptions-setting.
  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
  })

  -- Workaround because the session file will sometimes record a setting of 0.
  vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    callback = function() vim.opt.scrolloff = 4 end,
  })

  -- Display buffername in terminal title
  vim.o.title = true

  -- Display whitespace
  vim.o.list = true
  vim.o.listchars="tab:→ |,space:•,nbsp:␣,trail:¬,precedes:↯,extends:←"
  vim.o.showbreak="←"

  -- Make the vim UI a lot more minimalistic.
  vim.o.laststatus = 0

  -- Setting this as set statusline=" " causes a default statusline.
  -- Using vim.o.statusline = " " hides the status line content.
  vim.o.statusline = " "
  vim.o.cmdheight = 0
end

return M
