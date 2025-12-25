-- lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" }, -- Lazy load: only when opening files
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp", -- Ensure CMP integration
  },
  config = function()
    -- Error handling for required dependencies
    local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not mason_lsp_ok then
      vim.notify("mason-lspconfig not found!", vim.log.levels.ERROR)
      return
    end

    mason_lspconfig.setup()

    -- The on_attach function runs whenever a new LSP server attaches to a buffer
    local on_attach = function(client, bufnr)
      -- Helper function to make keymaps shorter
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      -- Essential LSP Keymaps (keeping only what you use)
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
      -- Use Conform for formatting (unified formatter)
      map("n", "<leader>cf", function()
        local conform_ok, conform = pcall(require, "conform")
        if conform_ok then
          conform.format({ async = true, lsp_fallback = true })
        else
          vim.lsp.buf.format({ async = true })
        end
      end, "Format Code")

      -- Diagnostic Keymaps with navigation
      map("n", "<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")
      map("n", "<leader>q", vim.diagnostic.setloclist, "Open Diagnostics List")
      map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
      map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

      -- Inlay hints toggle (if supported)
      if client.server_capabilities.inlayHintProvider then
        map("n", "<leader>th", function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
        end, "Toggle Inlay Hints")
      end

      -- Semantic tokens (enable semantic highlighting)
      if client.server_capabilities.semanticTokensProvider then
        vim.lsp.semantic_tokens.start(bufnr, client.id)
      end

      -- Document highlighting (optional visual feature)
      if client.server_capabilities.documentHighlightProvider then
        local highlight_group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = false })
        
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          group = highlight_group,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = bufnr,
          group = highlight_group,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end

    -- Diagnostic configuration
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
      underline = true,
      virtual_text = {
        spacing = 4,
        prefix = "●",
        source = "if_many", -- Show source if multiple sources
        format = function(diagnostic)
          -- Limit virtual text length to prevent clutter
          if #diagnostic.message > 50 then
            return diagnostic.message:sub(1, 50) .. "..."
          end
          return diagnostic.message
        end,
      },
      update_in_insert = false,
      severity_sort = true,
      float = {
        border = "rounded",
        source = "always", -- Always show source in float
        header = "",
        prefix = "",
      },
    })

    -- Setup capabilities with error handling
    local capabilities
    local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_ok then
      capabilities = cmp_lsp.default_capabilities()
    else
      capabilities = vim.lsp.protocol.make_client_capabilities()
    end

    -- Enhanced capabilities
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits" },
    }
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ruff",    -- Python linting/quickfixes (Ruff LSP)
        "ts_ls",
        "vue_ls",
        "eslint",  -- JS/TS/Vue linting
        "clangd",
      },
      handlers = {
        function(server_name)
          local opts = {
            on_attach = on_attach,
            capabilities = capabilities,
          }

          -- Special configuration for lua_ls
          if server_name == "lua_ls" then
            opts.settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                },
                diagnostics = {
                  globals = { "vim" }, -- Suppress 'undefined global vim' warnings
                },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
                telemetry = { enable = false },
                hint = {
                  enable = true, -- Enable inlay hints
                },
              },
            }
          
          -- Python (pyright)
          elseif server_name == "pyright" then
            opts.settings = {
              python = {
                analysis = {
                  typeCheckingMode = "basic",
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  diagnosticMode = "workspace",
                },
              },
            }
          
          -- Vue (volar) - only handles .vue files
          elseif server_name == "vue_ls" then
            opts.filetypes = { "vue" } -- Only handle .vue files
            opts.init_options = {
              vue = {
                hybridMode = false,
              },
            }

          -- TypeScript/JavaScript
          elseif server_name == "ts_ls" or server_name == "tsserver" then
            -- Safely get vue-language-server path for Vue support
            local vue_plugin_path = nil
            local mason_ok, mason_registry = pcall(require, "mason-registry")
            if mason_ok then
              local vue_ok, vue_pkg = pcall(function()
                return mason_registry.get_package("vue-language-server"):get_install_path()
              end)
              if vue_ok then
                vue_plugin_path = vue_pkg .. "/node_modules/@vue/language-server"
              end
            end

            opts.init_options = vue_plugin_path and {
              plugins = {
                {
                  name = "@vue/typescript-plugin",
                  location = vue_plugin_path,
                  languages = { "vue" },
                },
              },
            } or {}
            -- Exclude .vue files - handled by vue_ls
            opts.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" }
            opts.settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
              javascript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all",
                  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                  includeInlayFunctionParameterTypeHints = true,
                  includeInlayVariableTypeHints = true,
                  includeInlayPropertyDeclarationTypeHints = true,
                  includeInlayFunctionLikeReturnTypeHints = true,
                  includeInlayEnumMemberValueHints = true,
                },
              },
            }
          
          -- Rust
          elseif server_name == "rust_analyzer" then
            opts.settings = {
              ["rust-analyzer"] = {
                checkOnSave = {
                  command = "clippy",
                },
                inlayHints = {
                  enable = true,
                  chainingHints = true,
                  parameterHints = true,
                  typeHints = true,
                },
              },
            }
          
          -- Go
          elseif server_name == "gopls" then
            opts.settings = {
              gopls = {
                analyses = {
                  unusedparams = true,
                  shadow = true,
                },
                staticcheck = true,
                gofumpt = true,
                hints = {
                  assignVariableTypes = true,
                  compositeLiteralFields = true,
                  compositeLiteralTypes = true,
                  constantValues = true,
                  functionTypeParameters = true,
                  parameterNames = true,
                  rangeVariableTypes = true,
                },
              },
            }
          
          -- C/C++ (clangd)
          elseif server_name == "clangd" then
            opts.capabilities.offsetEncoding = { "utf-16" }
            opts.cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            }

          -- Ruff (Python linting/quickfixes) - formatting handled by Conform
          elseif server_name == "ruff" then
            opts.on_attach = function(client, bufnr)
              -- Disable Ruff's formatting capability; Conform handles formatting
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
              -- Call the shared on_attach for keymaps
              on_attach(client, bufnr)
            end

          -- ESLint (JS/TS/Vue linting) - formatting handled by Conform/Prettier
          elseif server_name == "eslint" then
            opts.on_attach = function(client, bufnr)
              -- Disable ESLint's formatting capability; Conform handles formatting
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
              -- Call the shared on_attach for keymaps
              on_attach(client, bufnr)
            end
            opts.settings = {
              -- Use flat config if available
              experimental = {
                useFlatConfig = nil, -- Auto-detect
              },
            }
          end

          -- Safe setup with error handling and logging
          local setup_ok, err = pcall(function()
            require('lspconfig')[server_name].setup(opts)
          end)
          
          if not setup_ok then
            vim.notify(
              string.format("Failed to setup %s: %s", server_name, err),
              vim.log.levels.ERROR
            )
          end
        end,
      }
    })
    
    -- Format on save (optional - uncomment to enable)
    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   callback = function()
    --     vim.lsp.buf.format({ async = false })
    --   end,
    -- })
  end,
}
