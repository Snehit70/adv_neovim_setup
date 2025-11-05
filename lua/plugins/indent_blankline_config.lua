return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = {"BufReadPost", "BufNewFile"},
  opts = {
    indent = {
      char = "│", -- feel free to try: "┊", "¦", "⎸", "▏"
      tab_char = "│", -- Character for tab indentation
      highlight = nil,
      smart_indent_cap = true, -- Prevents excessive indent lines in deeply nested code
    },
    whitespace = {
      remove_blankline_trail = false,
    },
    scope = {
      enabled = true,
      show_start = true,
      show_end = true,
      show_exact_scope = true, -- Shows exact scope boundaries for better clarity
      priority = 1024, -- Higher priority for better multi-plugin compatibility
      highlight = { "Function", "Label" }, -- Treesitter-based context
      include = {
        node_type = {
          ["*"] = {
            "class",
            "function",
            "method",
            "block",
            "list_literal",
            "selector",
            "^if",
            "^table",
            "if_statement",
            "while_statement",
            "for_statement"
          },
        },
      },
    },
    exclude = {
      filetypes = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "dashboard",
        "alpha",
        "starter",
        "neo-tree",
        "NvimTree",
        "toggleterm",
        "Trouble",
        "trouble",
        "notify",
        "markdown",
        "json",
        "txt",
      },
      buftypes = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
      },
    },
  },
}
