return {
  "numToStr/Comment.nvim",
  event = "VeryLazy", -- Loads when you start interacting (key press)
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring", -- Enables JSX/Jinja support
  },
  config = function()
    require("Comment").setup({
      padding = true,
      sticky = true,
      ignore = "^$", -- Ignore empty lines when commenting
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
        extended = false, -- Disable unused 'gs' text-object
      },
      -- Modern ts-context-commentstring integration
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
  end,
}
