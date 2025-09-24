-- lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
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
      map("n", "<leader>cf", vim.lsp.buf.format, "Format Code")

      -- Diagnostic Keymaps (keeping only what you might use)
      map("n", "<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")
      map("n", "<leader>q", vim.diagnostic.setloclist, "Open Diagnostics List")

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
      virtual_text = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Setup capabilities with error handling
    local capabilities
    local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if cmp_ok then
      capabilities = cmp_lsp.default_capabilities()
    else
      capabilities = vim.lsp.protocol.make_client_capabilities()
    end

    mason_lspconfig.setup_handlers({
      -- Default handler for all servers
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
            },
          }
        end

        vim.lsp.config(server_name, opts)
      end,
    })
  end,
}
