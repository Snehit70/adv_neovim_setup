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
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end

    -- language-specific rules (e.g., for Jinja)
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.add_rules({
      Rule("{{", "}}", "htmldjango"):with_move(cond.none()),
      Rule("{%", "%}", "htmldjango"):with_move(cond.none()),
      Rule("{#", "#}", "htmldjango"):with_move(cond.none()),
    })
  end,
}
