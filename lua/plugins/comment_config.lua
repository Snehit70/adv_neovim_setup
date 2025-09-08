return {
  "numToStr/Comment.nvim",
  event = "VeryLazy", -- Loads when you start interacting (key press)
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring", -- Enables JSX/Jinja support
  },
  config = function()
    require("ts_context_commentstring").setup({
      enable_autocmd = false,
    })

    require("Comment").setup({
      padding = true,
      sticky = true,
      ignore = nil,
      toggler = {
        line = "gcc", -- Toggle line comment
        block = "gbc", -- Toggle block comment
      },
      opleader = {
        line = "gc", -- Operator-pending line comment (gc + motion)
        block = "gb", -- Operator-pending block comment
      },
      extra = {
        above = "gcO", -- Add comment above
        below = "gco", -- Add comment below
        eol = "gcA", -- Add comment at end of line
      },
      mappings = {
        basic = true,     -- gcc, gbc
        extra = true,     -- gco, gcO, gcA
        extended = true,  -- Enables 'gs' text-object commenting
      },
    })
  end,
}
