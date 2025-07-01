-- lua/plugins/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
      map("n", "gr", vim.lsp.buf.references, "Find References")

      map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
      map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
      map("n", "<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")
      map("n", "<leader>q", vim.diagnostic.setloclist, "Open Diagnostics List")

      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
      underline = true,
      virtual_text = true,
      update_in_insert = false,
      severity_sort = true,
    })

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
      pyright = {},
      ts_ls= {},
      html = {},
      cssls = {},
      bashls = {},
      jsonls = {},
    }

    for server, opts in pairs(servers) do
      opts.on_attach = on_attach
      opts.capabilities = capabilities
      lspconfig[server].setup(opts)
    end
  end,
}
