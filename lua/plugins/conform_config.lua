-- Conform plugin configuration
return {
  -- Conform plugin specification
  "stevearc/conform.nvim",
  -- Load on buffer write or read
  event = { "BufWritePre", "BufReadPre" },
  cmd = { "ConformInfo" },

  -- Keymap for formatting
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 1000 })
      end,
      desc = "Format buffer",
    },
  },

  -- Configuration function
  config = function()
    -- Setup conform with formatters
    require("conform").setup({
      -- Map filetypes to formatters
      formatters_by_ft = {
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        -- Optional formatters
        jinja = { "djlint" },
        htmldjango = { "djlint" },
      },
      -- Define formatter configurations
      formatters = {
        djlint = {
          prepend_args = { "--reformat" },
        },
      },
    })
  end,
}
