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
     show_end_of_buffer = true, -- Show ~ at end of window to indicate empty lines
     term_colors = true,
     dim_inactive = {
       enabled = false, -- Dimming inactive windows is disabled
       shade = "dark",
       percentage = 0.15,
     },
     no_italic = false, -- Allow italic styling as defined in 'styles'
     no_bold = false, -- Allow bold styling as defined in 'styles'
     no_underline = false,
     styles = {
       comments = { "italic" },
       conditionals = { "italic" },
       loops = { "italic" },
       functions = { "bold" },
       keywords = { "italic" },
       strings = { "italic" },
       variables = { "italic" },
       numbers = {},
       booleans = { "bold" },
       properties = { "italic" },
       types = { "italic" },
       operators = {},
     },
     color_overrides = {},
     custom_highlights = function(colors)
       return {
         LineNr = { fg = colors.sky },
         NormalFloat = { bg = colors.mantle },
         Search = { bg = colors.lavender, fg = colors.base },
         CursorLineNr = { fg = colors.text, style = { "bold" } },
       }
     end,
     
     integrations = {
       cmp = true,
       gitsigns = true,
       bufferline = true,
       neotree = true,
       treesitter = true,
     },
   })
   vim.cmd.colorscheme("catppuccin")
 end,
}
