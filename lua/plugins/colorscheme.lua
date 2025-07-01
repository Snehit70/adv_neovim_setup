-- ~/.config/nvim/lua/plugins/colorscheme.lua

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,

  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      show_end_of_buffer = false, -- hides ~ at end of window
      term_colors = true,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = true,
      no_bold = true,
      no_underline = false, -- you said "as blank", so default is false
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = { "italic" },
        operators = {},
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations=true,
      integrations = {
      },
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
