return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.g.mkdp_auto_start = 0      -- don't auto preview
    vim.g.mkdp_auto_close = 1      -- auto close preview tab when buffer is closed
    vim.g.mkdp_refresh_slow = 0    -- live reload
    vim.g.mkdp_command_for_global = 0
    vim.g.mkdp_browser = ""        -- empty to use system default browser
    vim.g.mkdp_echo_preview_url = 1 -- show URL in command line
    vim.g.mkdp_page_title = "${name} - Markdown Preview"

    -- Optional: style tweaks
    vim.g.mkdp_theme = "dark"
  end,
  keys = {
    {
      "<leader>mp",
      "<cmd>MarkdownPreviewToggle<cr>",
      desc = "Toggle Markdown Preview",
      ft = "markdown"
    },
  },
}
