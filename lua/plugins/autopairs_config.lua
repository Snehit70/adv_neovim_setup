return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local npairs = require("nvim-autopairs")
    
    npairs.setup({
      -- Basic settings
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      
      -- Behavior settings
      disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
        "vim",
        "sh",
        "bash",
        "zsh",
        "gitcommit",
        "help",
      },
      -- Advanced options
      disable_in_macro = true,
      disable_in_visualblock = false,
      disable_in_replace_mode = true,
      ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
      enable_moveright = true,
      enable_afterquote = true,
      enable_check_bracket_line = false,
      enable_bracket_in_quote = true,
      enable_abbr = false,
      break_undo = true,
      check_comma = true,
      map_c_h = false,
      map_c_w = false,
    })

    -- CMP integration
    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- Custom rules for Django templates
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    -- Django template rules
    npairs.add_rules({
      -- Django variable tags: {{ }}
      Rule("{{ ", " }}", "htmldjango")
        :with_pair(cond.not_after_regex(" }}", 1))
        :with_pair(cond.not_before_regex("{{ ", 1))
        :with_pair(cond.not_inside_quote())
        :with_move(cond.none()),

      -- Django template tags: {% %}
      Rule("{% ", " %}", "htmldjango")
        :with_pair(cond.not_after_regex(" %}", 1))
        :with_pair(cond.not_before_regex("{% ", 1))
        :with_pair(cond.not_inside_quote())
        :with_move(cond.none()),

      -- Django comment tags: {# #}
      Rule("{# ", " #}", "htmldjango")
        :with_pair(cond.not_after_regex(" #}", 1))
        :with_pair(cond.not_before_regex("{# ", 1))
        :with_pair(cond.not_inside_quote())
        :with_move(cond.none()),

      -- JSX/React fragment tags: <> </>
      Rule("<>", "</>", { "javascriptreact", "typescriptreact" })
        :with_pair(cond.not_inside_quote())
        :with_move(cond.none()),

      -- Markdown code blocks: ``` ```
      Rule("```", "```", "markdown")
        :with_pair(cond.not_inside_quote())
        :with_move(function(opts)
          return opts.next_char ~= "`"
        end),

      -- Python f-strings: f"" (smart quotes)
      Rule('f"', '"', "python")
        :with_pair(cond.not_after_text("f"))
        :with_pair(cond.not_inside_quote()),
    })
  end
}
