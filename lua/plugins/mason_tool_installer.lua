-- Auto-install external tools via Mason
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = { "williamboman/mason.nvim" },
  event = "VeryLazy",
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Python
        "ruff",           -- Linter + formatter (used by Conform and Ruff LSP)

        -- JavaScript/TypeScript/Vue
        "eslint-lsp",     -- ESLint language server (vscode-eslint-language-server)
        "prettierd",      -- Fast Prettier daemon for formatting

        -- Java
        "jdtls",          -- Eclipse JDT Language Server

        -- C/C++
        "clang-format",   -- Formatter for C/C++

        -- Lua
        "stylua",         -- Lua formatter
      },

      -- Automatically update tools
      auto_update = false,

      -- Run on start (after mason is ready)
      run_on_start = true,

      -- Delay before starting install
      start_delay = 3000, -- 3 second delay
    })
  end,
}
