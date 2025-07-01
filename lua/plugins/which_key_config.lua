-- ~/.config/nvim/lua/plugins/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    spec = {
      {
        mode = { "n", "v" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "help" },
        { "<leader>l", group = "lsp" },
        { "<leader>s", group = "search" },
        { "<leader>t", group = "toggle" },
        { "<leader>w", group = "windows" },
        { "<leader>x", group = "diagnostics/quickfix" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
      },
    },
    preset = "modern", -- classic, modern, helix
    delay = 300,
    expand = 1, -- expand groups when <= n mappings
    notify = true,
    triggers = {
      { "<auto>", mode = "nixsotc" },
      { "<leader>", mode = { "n", "v" } },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
