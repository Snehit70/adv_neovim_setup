return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown", "mdx", "rmd" }, -- Added more markdown filetypes
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    -- Basic settings
    vim.g.mkdp_auto_start = 0 -- Don't auto-start preview
    vim.g.mkdp_auto_close = 1 -- Auto-close when leaving markdown buffer
    vim.g.mkdp_refresh_slow = 0 -- Fast refresh
    vim.g.mkdp_command_for_global = 0 -- Only available for markdown files
    
    -- Browser configuration
    vim.g.mkdp_browser = "" -- Empty = system default browser
    -- Examples for specific browsers:
    -- vim.g.mkdp_browser = "firefox"
    -- vim.g.mkdp_browser = "chromium"
    -- vim.g.mkdp_browser = "/usr/bin/google-chrome-stable"
    
    vim.g.mkdp_echo_preview_url = 1 -- Show preview URL in command line
    
    -- Preview window options
    vim.g.mkdp_open_to_the_world = 0 -- Only accessible from localhost
    vim.g.mkdp_open_ip = "127.0.0.1" -- Bind to localhost
    vim.g.mkdp_port = "" -- Empty = auto-select port, or set custom like "8080"
    
    -- Content and styling
    vim.g.mkdp_page_title = "「${name}」" -- Preview page title with decorative brackets
    vim.g.mkdp_theme = "dark" -- "dark" or "light"
    
    -- Preview options
    vim.g.mkdp_preview_options = {
      mkit = {}, -- markdown-it options for rendering
      katex = {}, -- KaTeX options for math typesetting
      uml = {}, -- PlantUML options
      maid = {}, -- Mermaid diagram options
      disable_sync_scroll = 0, -- Enable synchronized scrolling
      sync_scroll_type = "middle", -- "middle", "top" or "relative"
      hide_yaml_meta = 1, -- Hide YAML frontmatter
      sequence_diagrams = {}, -- js-sequence-diagrams options
      flowchart_diagrams = {}, -- flowchart.js options
      content_editable = false, -- Don't allow editing in preview
      disable_filename = 0, -- Show filename in preview
      toc = {} -- Table of contents options
    }
    
    -- Advanced markdown features
    vim.g.mkdp_markdown_css = "" -- Custom CSS file path (empty = default)
    -- Example: vim.g.mkdp_markdown_css = vim.fn.stdpath('config') .. '/markdown.css'
    
    vim.g.mkdp_highlight_css = "" -- Custom highlight.js CSS (empty = default github theme)
    -- Example for custom theme: vim.g.mkdp_highlight_css = vim.fn.stdpath('config') .. '/highlight.css'
    
    -- Custom scripts and plugins
    vim.g.mkdp_combine_preview = 0 -- Don't combine preview window
    vim.g.mkdp_combine_preview_auto_refresh = 1 -- Auto-refresh combined preview
    
    -- Recognize filetypes
    vim.g.mkdp_filetypes = { "markdown", "mdx", "rmd" }
    
    -- Image options
    vim.g.mkdp_images_path = "" -- Custom path for images (empty = buffer directory)
    
    -- Performance options
    vim.g.mkdp_browserfunc = "" -- Custom browser function (advanced usage)
    
    -- Auto-commands for enhanced functionality
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "mdx", "rmd" },
      callback = function()
        -- Additional markdown-specific settings
        vim.opt_local.conceallevel = 2 -- Hide markup symbols
        vim.opt_local.concealcursor = "nc" -- Conceal in normal and command mode
        vim.opt_local.wrap = true -- Enable line wrap
        vim.opt_local.linebreak = true -- Break lines at word boundaries
        vim.opt_local.spell = true -- Enable spell checking
        vim.opt_local.spelllang = "en_us" -- Set spell language
      end,
    })
  end,
  keys = {
    {
      "<leader>mp",
      "<cmd>MarkdownPreviewToggle<cr>",
      desc = "Toggle Markdown Preview",
      ft = "markdown"
    },
    {
      "<leader>mo",
      "<cmd>MarkdownPreview<cr>",
      desc = "Open Markdown Preview",
      ft = "markdown"
    },
    {
      "<leader>mc",
      "<cmd>MarkdownPreviewStop<cr>",
      desc = "Stop Markdown Preview",
      ft = "markdown"
    },
  },
}
