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
     show_end_of_buffer = false, -- Don't show ~ (matches fillchars config)
     term_colors = true,
     dim_inactive = {
       enabled = true, -- Dim inactive splits for better focus
       shade = "dark",
       percentage = 0.10, -- Subtle dimming
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
       booleans = { "bold" },
       properties = { "italic" },
       types = { "italic" },
     },
     color_overrides = {},
     custom_highlights = function(colors)
       return {
         -- Line numbers
         LineNr = { fg = colors.sky },
         NormalFloat = { bg = colors.mantle },
         Search = { bg = colors.lavender, fg = colors.base },
         CursorLineNr = { fg = colors.text, style = { "bold" } },
         
         -- CMP ghost text
         CmpGhostText = { fg = colors.overlay0, italic = true },
         
         -- Telescope colors
         TelescopeNormal = { bg = colors.mantle },
         TelescopeBorder = { fg = colors.blue, bg = colors.mantle },
         TelescopePromptNormal = { bg = colors.surface0 },
         TelescopePromptBorder = { fg = colors.blue, bg = colors.surface0 },
         TelescopePromptTitle = { fg = colors.base, bg = colors.blue },
         TelescopePreviewTitle = { fg = colors.base, bg = colors.green },
         TelescopeResultsTitle = { fg = colors.base, bg = colors.mauve },
         
         -- Better diff colors
         DiffAdd = { bg = colors.green, fg = colors.base },
         DiffChange = { bg = colors.yellow, fg = colors.base },
         DiffDelete = { bg = colors.red, fg = colors.base },
         DiffText = { bg = colors.yellow, fg = colors.base, style = { "bold" } },
         
         -- Indent blankline
         IndentBlanklineChar = { fg = colors.surface0 },
         IndentBlanklineContextChar = { fg = colors.surface2 },
       }
     end,
     
     integrations = {
       cmp = true,
       gitsigns = true,
       bufferline = true,
       neotree = true,
       treesitter = true,
       telescope = {
         enabled = true,
       },
       which_key = true,
       mason = true,
       noice = true,
       indent_blankline = {
         enabled = true,
         colored_indent_levels = false,
       },
       native_lsp = {
         enabled = true,
         virtual_text = {
           errors = { "italic" },
           hints = { "italic" },
           warnings = { "italic" },
           information = { "italic" },
         },
         underlines = {
           errors = { "underline" },
           hints = { "underline" },
           warnings = { "underline" },
           information = { "underline" },
         },
       },
     },
   })
   vim.cmd.colorscheme("catppuccin")
 end,
}
