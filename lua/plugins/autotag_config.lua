-- This file configures the 'nvim-ts-autotag' plugin.
-- nvim-ts-autotag automatically closes and renames HTML/XML tags using Tree-sitter,
-- which is incredibly useful for web development and other markup languages.

return {
  "windwp/nvim-ts-autotag",
  -- Load the plugin only when entering Insert mode, as that's when tag manipulation is most relevant.
  event = "InsertEnter",
  -- 'ft' (filetype) specifies the file types for which this plugin should be active.
  -- This ensures the plugin only runs where it's needed, improving performance.
  ft = {
    "html", "xml", "javascript", "javascriptreact", -- Standard web languages
    "typescript", "typescriptreact", "markdown",     -- TypeScript and Markdown (for embedded HTML)
    "htmldjango", "jinja", "templ", "ejs",           -- Various templating languages
  },
  -- The 'config' function is executed when the plugin is loaded.
  config = function()
    -- Safely require the nvim-ts-autotag module. If it fails (e.g., plugin not installed),
    -- the function returns early to prevent errors.
    local ok, autotag = pcall(require, "nvim-ts-autotag")
    if not ok then return end

    -- Setup nvim-ts-autotag with custom options.
    autotag.setup({
      opts = {
        -- enable_close_on_slash: When true, typing '/' after an opening tag (e.g., <img/) will
        -- automatically complete it to a self-closing tag (e.g., <img />).
        -- This is common for void elements in HTML or self-closing components in JSX.
        enable_close_on_slash = true,     -- Enables self-closing tags like <img />

        -- enable_auto_close: When true, automatically inserts the closing tag as soon as you type
        -- the '>' character for an opening tag (e.g., typing '<div>' then '>' results in '<div></div>').
        enable_auto_close = true,         -- Automatically inserts closing tag when typing '>'

        -- disable_autotag_for_tags: A list of HTML/XML tag names for which autotag should NOT
        -- perform its auto-closing or auto-renaming actions. Useful for void elements or tags
        -- where you prefer manual control.
        disable_autotag_for_tags = {"br", "hr", "input", "img", "link", "meta"}, -- Disable autotag for specific tags

        -- enable_rename: When true, if you change an opening tag (e.g., <div> to <span>),
        -- its corresponding closing tag (</div>) will automatically update to </span>.
        enable_rename = true,            -- Avoid tag rename conflicts with other plugins

        -- enable_rename_on_typing: When true, the auto-renaming feature triggers incrementally
        -- as you type characters within an opening tag, providing instant visual feedback.
        enable_rename_on_typing = true,  -- Enable real-time renaming as you type

        -- excluded_filetypes: A list of file types where nvim-ts-autotag should be completely disabled.
        -- This provides an additional layer of exclusion beyond the 'ft' setting, useful for file types
        -- that do not use HTML/XML tags (e.g., JSON, YAML).
        excluded_filetypes = {"json", "yaml"}, -- Exclude autotag from these filetypes

        -- enable_close_on_rename: When false, if you rename an opening tag, it will NOT automatically
        -- insert a closing tag if one doesn't already exist. This is often set to false to prevent
        -- conflicts with other auto-pairing plugins (like nvim-autopairs) or to give more control.
        enable_close_on_rename = false,   -- Disables auto-rename behavior (prevents conflict)
      },
    })
  end,
}
