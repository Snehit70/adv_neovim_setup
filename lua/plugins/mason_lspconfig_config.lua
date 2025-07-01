-- lua/plugins/mason-lspconfig.lua
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = {
    ensure_installed = {
      "lua_ls",
      "pyright",
      "ts_ls",
      "html",
      "cssls",
      "bashls",
      "jsonls",
    },
  },
}
