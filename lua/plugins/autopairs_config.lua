return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp", -- integration with completion
  },
  config = function()
    local npairs = require("nvim-autopairs")

    npairs.setup({
      check_ts = true, -- enable Tree-sitter
      disable_filetype = {
        "TelescopePrompt",
        "vim",
        "markdown",
        "sh",
        "bash",
        "zsh",
        "toml",
      },
      fast_wrap = {
        map = "<M-e>", -- default: Alt+e
        chars = { "{", "[", "(", '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl",
        manual_position = true,
        highlight = "Search",
        highlight_grey = "Comment",
      },
    })

    -- cmp integration
    local cmp_status, cmp = pcall(require, "cmp")
    if cmp_status then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done)
    end

    -- language-specific rules (e.g., for Jinja)
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.add_rules({
      -- More specific conditions for Django template syntax
      Rule("{{", "}}", "htmldjango")
        :with_pair(cond.not_after_regex("}", 1))  -- Don't trigger if there's already a } after cursor
        :with_pair(cond.not_before_regex("{", 1)) -- Don't trigger if there's already a { before cursor
        :with_pair(cond.not_inside_quote())       -- Don't trigger inside quotes
        :with_move(cond.none()),

      Rule("{%", "%}", "htmldjango")
        :with_pair(cond.not_after_regex("%}", 1))
        :with_pair(cond.not_before_regex("{", 1))
        :with_pair(cond.not_inside_quote())
        :with_move(cond.none()),

      Rule("{#", "#}", "htmldjango")
        :with_pair(cond.not_after_regex("#}", 1))
        :with_pair(cond.not_before_regex("{", 1))
        :with_pair(cond.not_inside_quote())
        :with_move(cond.none()),
    })
  end,
}
