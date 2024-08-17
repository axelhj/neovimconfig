local filetypes = require("config.lspservers").filetypes
local servers = require("config.lspservers").servers

return {
  "neovim/nvim-lspconfig",
  event = { "VeryLazy" },
  dependencies = {
    { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
    "folke/neodev.nvim",
  },
  enabled = false,
  keys= {
    { "<Leader>fi", desc = "Telescope [f]ind lsp [i]mplementation" },
    { "<Leader>fr", desc = "Telescope [f]ind lsp [r]eferences" },
    { "<Leader>fs", desc = "Telescope [f]ind lsp document [s]ymbols" },
    { "<Leader>fS", desc = "Telescope [f]ind lsp workspace [S]ymbols" },
    { "gd", desc = "[g]oto [d]efinition" },
    { "gD", desc = "[g]oto [D]eclaration" },
    { "gDt", desc = "[g]oto [D]efinition of [t]ype" },
    { "gi", desc = "Goto [i]mplementation" },
    { "<leader>gd", "[g]oto [D]eclaration" },
    { "<leader>gt", "[g]oto [t]ype-definition" },
  },
  config = function()
    local on_attach = function(_, bufnr)
      local modemap = function(mode, keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
      end
      local nmap = function(keys, func, desc) modemap("n", keys, func, desc) end
      local imap = function(keys, func, desc) modemap("i", keys, func, desc) end
      local vmap = function(keys, func, desc) modemap("v", keys, func, desc) end

      nmap("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
      nmap("gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
      nmap("gi", require("telescope.builtin").lsp_implementations, "Goto [i]mplementation")

      nmap("<leader>gd", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
      nmap("<leader>gty", vim.lsp.buf.type_definition, "[g]oto [ty]pe-definition")
      nmap("<leader>fi", require("telescope.builtin").lsp_implementations, "Find [i]mplementations")
      nmap("<leader>fr", require("telescope.builtin").lsp_references, "[f]ind [r]eferences")
      nmap("<leader>fs", require("telescope.builtin").lsp_document_symbols, "[f]ind document [s]ymbols")
      nmap("<leader>fS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[f]ind workspace [S]ymbols")

      nmap("<leader>vr", vim.lsp.buf.rename, "[v]iew [r]ename float")
      nmap("<leader>va", vim.lsp.buf.code_action, "[v]iew code [a]ctions")

      nmap("K", vim.lsp.buf.hover, "[K] Hover Documentation")
      nmap("<M-k>", vim.lsp.buf.signature_help, "Alt-[k] Signature Documentation")
      imap("<M-k>", vim.lsp.buf.signature_help, "Alt-[k] Signature Documentation")
      vmap("<M-k>", vim.lsp.buf.signature_help, "Alt-[k] Signature Documentation")

      nmap("<leader>dwa", vim.lsp.buf.add_workspace_folder, "[w]orkspace [a]dd Folder")
      nmap("<leader>dwr", vim.lsp.buf.remove_workspace_folder, "[w]orkspace [r]emove Folder")
      nmap("<leader>dwl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[w]orkspace [l]ist Folders")

      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    -- Setup neovim lua configuration
    require("neodev").setup({})

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Capabilities required for the visualstudio lsps (css, html, etc)
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Add nvim-lspconfig plugin
    local lspconfig = require "lspconfig"

    for lsp, setup in pairs(servers) do
      local setupOptions = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = setup.settings or {},
        flags = {
          -- Minimize LSP work
          debounce_text_changes = 3500,
        },
        filetypes = filetypes[lsp],
      }
      if setup.options then
        if setup.options.root_dir then
          setupOptions.root_dir = setup.options.root_dir
        end
        if setup.options.cmd then
          setupOptions.cmd = setup.options.cmd
        end
        if setup.options.on_attach then
          local original_on_attach = setupOptions.on_attach
          setupOptions.on_attach = function(_, bufnr)
            original_on_attach(_, bufnr)
            setup.options.on_attach(_, bufnr)
          end
        end
      end
      lspconfig[lsp].setup(setupOptions)
    end
  end
}
