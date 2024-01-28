local filetypes = {
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
  -- clangd = {
  --   options = {
  --     cmd = { 'clangd', '--query-driver=C:\\msys64\\mingw64\\bin\\g++.exe' },
  --   },
  -- },
  -- gopls = {},
  ccls = {
    init_options = {
      compilationDatabaseDirectory = "build";
      index = {
        threads = 0;
      },
      clang = {
        excludeArgs = {
          "-frounding-math",
          "-finput-charset=UTF-8",
          "-fexec-charset=850",
        },
        extraArgs = { "--gcc-toolchain=C:\\msys64\\mingw64" },
      },
    }
  },
  pyright = {},
  -- rust_analyzer = {},
  -- eslint = {},
  tailwindcss = {
    options = {
      on_attach = function(_, bufnr)
        require("tailwindcss-colors").buf_attach(bufnr)
      end,
    },
  },
  tsserver = {},
  -- biome = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  cmake =  {},
  csharp_ls = {
    options = {
      root_dir = function(startpath)
        local lspconfig = require'lspconfig'
        return lspconfig.util.root_pattern("*.sln")(startpath)
          or lspconfig.util.root_pattern("*.csproj")(startpath)
          or lspconfig.util.root_pattern("*.fsproj")(startpath)
          or lspconfig.util.root_pattern(".git")(startpath)
      end,
    },
  },
  lua_ls = {
    settings = {
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
  },
}

local on_attach = function(_, bufnr)
  local modemap = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end
  local nmap = function(keys, func, desc) modemap('n', keys, func, desc) end
  local imap = function(keys, func, desc) modemap('i', keys, func, desc) end
  local vmap = function(keys, func, desc) modemap('v', keys, func, desc) end

  nmap('gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
  nmap('gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('gDt', vim.lsp.buf.type_definition, '[g]oto [D]efinition of [t]ype')
  nmap('gi', require('telescope.builtin').lsp_implementations, 'Goto [i]mplementation')

  nmap('<leader>gd', vim.lsp.buf.definition, '[g]oto [d]efinition')
  nmap('<leader>gD', vim.lsp.buf.declaration, '[g]oto [D]eclaration')
  nmap('<leader>gDt', vim.lsp.buf.type_definition, '[g]oto [D]efinition of [t]ype')
  nmap('<leader>gi', require('telescope.builtin').lsp_implementations, 'Goto [i]mplementation')
  nmap('<leader>vr', require('telescope.builtin').lsp_references, '[v]iew [r]eferences')
  nmap('<leader>s', require('telescope.builtin').lsp_document_symbols, 'Document [s]ymbols')
  nmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')

  nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame float')
  nmap('<leader>va', vim.lsp.buf.code_action, '[v]iew code [a]ctions')

  nmap('K', vim.lsp.buf.hover, '[K] Hover Documentation')
  nmap('<M-k>', vim.lsp.buf.signature_help, 'Alt-[k] Signature Documentation')
  imap('<M-k>', vim.lsp.buf.signature_help, 'Alt-[k] Signature Documentation')
  vmap('<M-k>', vim.lsp.buf.signature_help, 'Alt-[k] Signature Documentation')

  nmap('<leader>dwa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd Folder')
  nmap('<leader>dwr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove Folder')
  nmap('<leader>dwl', function()
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

for lsp, setup in pairs(servers) do
  local setupOptions = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = setup.settings,
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

require("tailwindcss-colors").setup({})
