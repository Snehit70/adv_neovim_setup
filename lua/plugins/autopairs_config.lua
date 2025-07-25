-- This file configures the 'nvim-autopairs' plugin.
-- nvim-autopairs automatically inserts or deletes closing parentheses, brackets, quotes, etc.,
-- as you type, making coding faster and reducing syntax errors.

return {
  "windwp/nvim-autopairs",
  -- Load the plugin only when entering Insert mode, as that's when auto-pairing is relevant.
  event = "InsertEnter",
  -- Declare dependencies: nvim-autopairs integrates with nvim-cmp for smarter completion handling.
  dependencies = {
    "hrsh7th/nvim-cmp", -- Integration with the completion plugin
  },
  -- The 'config' function is executed when the plugin is loaded.
  config = function()
    -- Require the nvim-autopairs module.
    local npairs = require("nvim-autopairs")

    -- Setup nvim-autopairs with custom options.
    npairs.setup({
      -- map_cr: Controls behavior when pressing <CR> (Enter) inside a pair.
      -- When true, it automatically inserts a newline and indents, placing the closing pair on a new line.
      -- Example: typing '{' then <CR> results in:
      -- {
      --   |
      -- }
      map_cr = true, -- Map <CR> to auto insert newlines and indent

      -- map_bs: Controls behavior when pressing <BS> (Backspace) between a pair.
      -- When true, deleting an opening pair character also deletes its corresponding closing pair.
      -- Example: deleting '(' in '(|)' also deletes ')'.
      map_bs = true, -- Map <BS> to delete auto-paired characters

      -- disable_modes: A list of Neovim modes where autopairs should be disabled.
      -- 'v': Visual mode (prevents interference with selections).
      -- 'R': Replace mode (prevents interference with character replacement).
      disable_modes = {"v", "R"}, -- Disable autopairs in Visual and Replace modes

      -- ignored_next_char: A string of characters. If any of these characters are immediately
      -- after the cursor when an opening pair is typed, autopairs will NOT insert the closing pair.
      -- This prevents double-closing characters (e.g., typing '(' when ')' is already there).
      ignored_next_char = "{}[]()\"'", -- Don't insert pair if next char is one of these

      -- paste: Controls whether autopairs should be disabled during paste operations.
      -- When true, it prevents autopairs from inserting unwanted characters or interfering
      -- with the indentation of pasted content.
      paste = true, -- Disable autopairs during paste operations

      -- check_ts: Enable integration with Tree-sitter.
      -- Tree-sitter provides syntax parsing, allowing autopairs to make more intelligent decisions
      -- (e.g., not inserting a quote inside a comment).
      check_ts = true, -- enable Tree-sitter

      -- disable_filetype: A list of file types where nvim-autopairs should be completely disabled.
      -- This is useful for file types where auto-pairing might be more of a hindrance than a help.
      disable_filetype = {
        "TelescopePrompt", -- Input prompt for Telescope plugin
        "vim",             -- Vimscript files
        "markdown",        -- Markdown files (often free-form text)
        "sh",              -- Shell scripts
        "bash",            -- Bash scripts
        "zsh",             -- Zsh scripts
        "toml",            -- TOML configuration files
        "gitcommit",       -- Git commit messages
        "help",            -- Neovim help files
      },

      -- fast_wrap: This feature allows quickly wrapping selected text with a pair of characters.
      -- It has been commented out as per user request, as it was not being used.
      --- fast_wrap = { -- This section is commented out as per user request.
      ---   map = "<M-e>", -- Keybinding to trigger fast wrap (Alt+e)
      ---   chars = { "{", "[", "(", '"', "'" }, -- Characters that can be used for wrapping
      ---   pattern = [=[[%'%">%]%)%}%,]]=], -- Regex pattern to identify wrap-able characters
      ---   end_key = "$", -- Cursor moves to the end of wrapped content after wrapping
      ---   keys = "qwertyuiopzxcvbnmasdfghjkl", -- Keys used to select the wrapping character
      ---   manual_position = true,
      ---   highlight = "Search",
      ---   highlight_grey = "Comment",
      --- },

      -- enable_check_bracket_line: When true, enhances <CR> behavior inside brackets.
      -- If the line before the opening bracket is empty, it inserts two newlines,
      -- placing the closing bracket on a new line and the cursor on an indented line in between.
      -- This helps with consistent formatting of code blocks.
      enable_check_bracket_line = true -- Enable intelligent bracket line checking for auto-indentation
    })

    -- nvim-cmp integration:
    -- This section ensures nvim-autopairs works seamlessly with nvim-cmp (your completion plugin).
    -- It checks if nvim-cmp is loaded and then sets up an event listener.
    local cmp_status, cmp = pcall(require, "cmp")
    if cmp_status then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      -- When a completion is confirmed by nvim-cmp, nvim-autopairs adjusts its behavior
      -- to prevent inserting redundant closing characters.
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done)
    end

    -- Language-specific rules (e.g., for Jinja/Django templates):
    -- This section adds custom rules for specific file types where default auto-pairing
    -- might not be sufficient or might interfere with unique syntax.
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    npairs.add_rules({
      -- Rule for Jinja/Django template syntax: {{ ... }}
      Rule("{", "}", "htmldjango")
        :with_pair(cond.not_after_regex("}", 1))  -- Don't trigger if '}' is already after cursor
        :with_pair(cond.not_before_regex("{", 1)) -- Don't trigger if '{' is already before cursor
        :with_pair(cond.not_inside_quote())       -- Don't trigger inside quotes
        :with_move(cond.none()),

      -- Rule for Jinja/Django template syntax: {% ... %}
      Rule("{%", "%}", "htmldjango")
        :with_pair(cond.not_after_regex("%}", 1)) -- Don't trigger if '%' is already after cursor
        :with_pair(cond.not_before_regex("{", 1)) -- Don't trigger if '{' is already before cursor
        :with_pair(cond.not_inside_quote())       -- Don't trigger inside quotes
        :with_move(cond.none()),

      -- Rule for Jinja/Django template syntax: {# ... #}
      Rule("{#", "#}", "htmldjango")
        :with_pair(cond.not_after_regex("#}", 1)) -- Don't trigger if '#' is already after cursor
        :with_pair(cond.not_before_regex("{", 1)) -- Don't trigger if '{' is already before cursor
        :with_pair(cond.not_inside_quote())       -- Don't trigger inside quotes
        :with_move(cond.none()),
    })
  end
}
