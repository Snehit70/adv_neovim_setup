-- Terminal-based markdown preview using glow
-- Requires: glow (install via: sudo pacman -S glow OR brew install glow OR go install github.com/charmbracelet/glow@latest)
return {
  "ellisonleao/glow.nvim",
  cmd = "Glow", -- Lazy load on command
  ft = { "markdown", "mdx", "rmd" }, -- Also load for markdown files
  opts = {
    border = "rounded", -- Floating window border style
    style = "dark", -- "dark" or "light"
    pager = false, -- Don't use pager (show all content)
    width = 120, -- Preview window width
    height_ratio = 0.8, -- 80% of editor height
    width_ratio = 0.8, -- 80% of editor width
  },
  keys = {
    {
      "<leader>mg",
      "<cmd>Glow<cr>",
      desc = "Glow Markdown Preview (Terminal)",
      ft = { "markdown", "mdx", "rmd" },
    },
  },
}
