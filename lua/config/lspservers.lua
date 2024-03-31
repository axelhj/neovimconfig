local M = {}

M.filetypes = {
  tsserver = {
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "typescript",
    "typescriptreact",
    "typescript.tsx"
  },
  cmake = { "txt", "cmake" },
}

M.servers = {
  clangd = {
    options = {
      cmd = { "clangd", "--query-driver=C:\\msys64\\mingw64\\bin\\g++.exe" },
    },
  },
  -- ccls = {
  --   init_options = {
  --     compilationDatabaseDirectory = "build";
  --     index = {
  --       threads = 0;
  --     },
  --     clang = {
  --       excludeArgs = {
  --         "-frounding-math",
  --         "-finput-charset=UTF-8",
  --         "-fexec-charset=850",
  --       },
  --       extraArgs = { "--gcc-toolchain=C:\\msys64\\mingw64" },
  --     },
  --   }
  -- },
  pyright = {},
  tailwindcss = {
    options = {
      on_attach = function(_, bufnr)
        require("tailwindcss-colors").buf_attach(bufnr)
      end,
    },
  },
  tsserver = {
    single_file_support = false
  },
  cmake =  {
    command = "cmake-language-server",
    filetypes = { "cmake" },
    rootPatterns = { "build/" },
    initializationOptions = { buildDirectory = "build" }
  },
  csharp_ls = {
    options = {
      root_dir = function(startpath)
        local lspconfig = require"lspconfig"
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
            "vim",
            "require"
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
          version = "LuaJIT",
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        completion = {
          callSnippet = "Replace",
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
        format = {
          enable = false,
        },
      },
    },
  },
  -- gopls = {},
  -- rust_analyzer = {},
  -- eslint = {},
  -- biome = {},
  -- html = { filetypes = { "html", "twig", "hbs"} },
}

return M
