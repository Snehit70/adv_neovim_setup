return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
  opts = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    -- You can adjust these colors in your theme or override directly
    vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })

    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      return highlight
    end)

    require("ibl").setup({
      indent = {
        char = "│", -- feel free to try: "┊", "¦", "⎸", "▏"
        highlight = highlight,
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
