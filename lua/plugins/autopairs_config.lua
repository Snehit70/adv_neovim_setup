return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local npairs = require("nvim-autopairs")

    npairs.setup({
      map_cr = true,
      map_bs = true,
      disable_modes = {"v", "R"},
      ignored_next_char = "{}[]()\"'",
      paste = true,
      check_ts = true,
      disable_filetype = {
        "TelescopePrompt",
        "vim",
        "markdown",
        "sh",
        "bash",
        "zsh",
        "toml",
        "gitcommit",
        "help",
      },
      ---
      --  fast_wrap = { -- This section is commented out as per user request.
      --    map = "<M-e>", -- Keybinding to trigger fast wrap (Alt+e)
      --    chars = { "{", "[", "(", '"', "'" }, -- Characters that can be used for wrapping
      --    pattern = [=[[%'%=">%]%)%}%,]]=], -- Regex pattern to identify wrap-able characters
      --    end_key = "$", -- Cursor moves to the end of wrapped content after wrapping
      --    keys = "qwertyuiopzxcvbnmasdfghjkl", -- Keys used to select the wrapping character
      --    manual_position = true,
      --    highlight = "Search",
      --    highlight_grey = "Comment",
      --  },
      --
      enable_check_bracket_line = true
    })

    local cmp_status, cmp = pcall(require, "cmp")
    if cmp_status then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done)
    end

    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.add_rules({
      Rule("{ ", " }", "htmldjango")
        :with_pair(cond.not_after_regex(" }", 1))
        :with_pair(cond.not_before_regex(" { ", 1))
        :with_pair(cond.not_inside_quote())
        :with_move(cond.none()),

      Rule("{% ", " %}", "htmldjango")
        :with_pair(cond.not_after_regex(" %}", 1))
        :with_pair(cond.not_before_regex(" { ", 1))
        :with_pair(cond.not_inside_quote())
        :with_move(cond.none()),

      Rule("{# ", " #}", "htmldjango")
        :with_pair(cond.not_after_regex(" #}", 1))
        :with_pair(cond.not_before_regex(" { ", 1))
        :with_pair(cond.not_inside_quote())
        :with_move(cond.none()),
    })
  end
}