local filetypes = {
  biome = {},
  tsserver = {
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
}

local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- eslint = {},
  tsserver = {},
  biome = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  cmake =  {},
  lua_ls = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
        disable = {
          "required_fields",
          "missing-fields",
          "incomplete-signature-doc"
        },
      },
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      completion = {
        callSnippet = 'Replace',
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>vrn', vim.lsp.buf.rename, '[v]iew [r]e[n]ame float')
  nmap('<leader>vc', vim.lsp.buf.code_action, '[v]iew [c]ode Actions')

  nmap('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
  nmap('vrr', require('telescope.builtin').lsp_references, '[v]iew [r]eferences')
  nmap('I', require('telescope.builtin').lsp_implementations, 'Goto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')

  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>ds', vim.lsp.buf.signature_help, 'Signature Documentation')

  nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[w]orkspace [l]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Setup neovim lua configuration
require('neodev').setup({})

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Capabilities required for the visualstudio lsps (css, html, etc)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Add nvim-lspconfig plugin
local lspconfig = require 'lspconfig'

for lsp, settings in pairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = settings,
    filetypes = filetypes[lsp],
  }
end

