return {
  "numToStr/Comment.nvim",
  event = "VeryLazy", -- Loads when you start interacting (key press)
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring", -- Enables JSX/Jinja support
  },
  config = function()
    -- Context-aware comment strings (e.g., JSX, Jinja)
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
      pre_hook = function(ctx)
        -- Enable ts-context-commentstring for filetypes like jsx, tsx, jinja, etc.
        local utils = require("ts_context_commentstring.internal")
        return utils.calculate_commentstring({
          key = ctx.ctype == require("Comment.utils").ctype.line and "__default" or "__multiline",
          location = ctx.ctype == require("Comment.utils").ctype.block and ctx.range.start or nil,
        })
      end,
      -- This hook runs *after* a comment is applied.
      post_hook = function(ctx)
        if ctx.ctype == require("Comment.utils").ctype.line then
          if ctx.cmotion == require("Comment.utils").cmotion.line then
            -- Move the cursor down one line after a line comment action (gcc).
            vim.api.nvim_feedkeys("j", "n", false)
          end
        end
      end,
    })
  end,
}
