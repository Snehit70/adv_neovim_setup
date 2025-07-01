-- lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- These are required for lspconfig to work nicely with mason.nvim
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- The on_attach function runs whenever a new LSP server attaches to a buffer.
    -- This is where we define buffer-local keymaps and other buffer-local settings.
    local on_attach = function(client, bufnr)
      -- A helper function to make keymaps shorter
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      -- Essential LSP Keymaps
      -- These mappings are set locally in the buffer where the LSP is active.
      -- For more information, see `:help vim.lsp.*`
      map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
      map("n", "gr", vim.lsp.buf.references, "Find References")

      -- Diagnostic Keymaps
      -- For navigating errors, warnings, etc.
      map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
      map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
      map("n", "<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")
      map("n", "<leader>q", vim.diagnostic.setloclist, "Open Diagnostics List")

      -- This is optional, but it's a nice touch.
      -- It highlights the symbol under the cursor.
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

    -- Set up diagnostic signs (the icons in the gutter)
    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
      underline= true,
      virtual_text = true,
      update_in_insert = false,
      severity_sort = true,
    })
    
    -- This is the base capabilities object that we'll modify later
    local capabilities =require("cmp_nvim_lsp").default_capabilities()

    -- The main setup loop.
    -- This gets the list of servers installed by mason-lspconfig and sets them up.
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup_handlers({
      -- The first argument is the server name.
      -- The second argument is the setup options table.
      function(server_name)
        local opts ={
        on_attach = on_attach,
        capabilities = capabilities,
        }
        
        -- Supress 'undefined global `vim`' for lua_ls
        if server_name == "lua_ls" then 
        opts.settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              },
            diagnostics = {
              globals = { "vim" }, -- Tell the language server that 'vim' is a global varible 
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("",true),
                checkThirdParty = false,
              },
              telemetry = {enable = false},
            },
          }
        end
        
        lspconfig[server_name].setup(opts)
        end,
    })
  end,
}
