return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
  opts = function()
    require("ibl").setup({
      indent = {
        char = "│", -- feel free to try: "┊", "¦", "⎸", "▏"
        highlight = nil,
      },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        highlight = { "Function", "Label" }, -- Treesitter-based context
      },
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "lazy",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "markdown",
          "json",
          "txt",
        },
      },
    })
  end,
}
