-- ~/.config/nvim/lua/plugins/colorscheme.lua

return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_commandline = false,
      contrast = "hard", -- can be "hard", "medium", or "soft"
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    })
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
