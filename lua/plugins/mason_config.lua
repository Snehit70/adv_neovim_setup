-- lua/plugins/mason.lua

return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Import mason
    local mason = require("mason")

    -- Import mason-lspconfig
    local mason_lspconfig = require("mason-lspconfig")

    -- Enable mason
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    mason_lspconfig.setup({
      -- List of LSPs to install automatically
      ensure_installed = {
        "lua_ls",
        "pyright",
        "ts_ls",
        "html",
        "cssls",
        "bashls",
        "jsonls",
      },
      -- This setting is true by default, meaning all LSP servers installed through Mason
      -- will be automatically set up by lspconfig.
      automatic_installation = true,
    })
  end,
}
