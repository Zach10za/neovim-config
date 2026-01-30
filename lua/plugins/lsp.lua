-- LSP Configuration with Mason and nvim-lspconfig
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Enhanced capabilities for autocompletion
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Diagnostic symbols in the gutter
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      })

      -- LSP keymaps (only active when LSP attaches)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          local keymap = vim.keymap.set

          -- Navigation (using fzf-lua)
          keymap("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", vim.tbl_extend("force", opts, { desc = "Go to definition" }))
          keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
          keymap("n", "gr", "<cmd>FzfLua lsp_references<CR>", vim.tbl_extend("force", opts, { desc = "Show references" }))
          keymap("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", vim.tbl_extend("force", opts, { desc = "Show implementations" }))
          keymap("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

          -- Information
          keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover documentation" }))
          keymap("n", "<leader>k", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

          -- Actions
          keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code actions" }))
          keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

          -- Diagnostics
          keymap("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))
          keymap("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
          keymap("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

          -- Format
          keymap("n", "<leader>lf", function()
            vim.lsp.buf.format({ async = true })
          end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
        end,
      })

      -- Setup mason-lspconfig to automatically setup servers
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "pyright",
          "ruff",
          "rust_analyzer",
          "html",
          "cssls",
          "jsonls",
          "yamlls",
          "taplo",
        },
        automatic_installation = true,
        handlers = {
          -- Default handler for all servers
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          -- Lua with Neovim-specific settings
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = {
                    globals = { "vim" },
                  },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,

          -- Ruff for Python linting and formatting
          ["ruff"] = function()
            lspconfig.ruff.setup({
              capabilities = capabilities,
              init_options = {
                settings = {
                  lineLength = 100,
                  lint = {
                    enable = true,
                    select = { "E", "F", "W", "I", "UP", "B", "C4", "SIM" },
                  },
                  format = {
                    enable = true,
                  },
                },
              },
            })
          end,

          -- Pyright for Python type checking and navigation
          ["pyright"] = function()
            lspconfig.pyright.setup({
              capabilities = capabilities,
              settings = {
                pyright = {
                  disableOrganizeImports = true,
                },
                python = {
                  analysis = {
                    typeCheckingMode = "basic",
                    diagnosticSeverityOverrides = {
                      reportUnusedImport = "none",
                      reportUnusedVariable = "none",
                    },
                  },
                },
              },
            })
          end,

          -- YAML with schema support
          ["yamlls"] = function()
            lspconfig.yamlls.setup({
              capabilities = capabilities,
              settings = {
                yaml = {
                  schemaStore = {
                    enable = true,
                    url = "https://www.schemastore.org/api/json/catalog.json",
                  },
                  schemas = {
                    ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                    ["https://json.schemastore.org/github-action.json"] = "action.yml",
                    ["https://json.schemastore.org/docker-compose.json"] = "docker-compose*.yml",
                    ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
                    ["https://json.schemastore.org/pre-commit-config.json"] = ".pre-commit-config.yaml",
                  },
                  validate = true,
                  completion = true,
                  hover = true,
                },
              },
            })
          end,
        },
      })
    end,
  },
}
