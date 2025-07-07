return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Enhanced notifications
    notifier = {
      enabled = true,
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- Style the notifications
      style = "compact", -- or "fancy"
      top_down = false, -- show notifications from bottom up
    },

    -- Git enhancements
    git = {
      enabled = true,
    },
    
    gitbrowse = {
      enabled = true,
    },

    -- Terminal (alternative to toggleterm)
    terminal = {
      enabled = true,
      -- Different keymaps so you can compare
      win = {
        style = "terminal",
        position = "float",
        backdrop = 60,
        height = 0.8,
        width = 0.8,
        border = "rounded",
      },
    },

    -- Additional useful features
    quickfile = {
      enabled = true, -- fast file operations
    },
    
    statuscolumn = {
      enabled = true, -- enhanced status column
    },

    words = {
      enabled = true, -- highlight word under cursor
    },

    -- Scroll improvements
    -- scroll = {
    --   enabled = true,
    --   animate = {
    --     duration = { step = 15, total = 250 },
    --     easing = "linear",
    --   },
    -- },

    -- Indent guides (you can disable if you prefer indent-blankline)
    indent = {
      enabled = false, -- keeping false since you have indent-blankline
    },

    -- Input enhancements
    input = {
      enabled = true,
    },

    -- Rename utility
    rename = {
      enabled = true,
    },
  },
  
  keys = {
    -- Terminal keymaps (different from toggleterm)
    { "<leader>tx", function() Snacks.terminal() end, desc = "Toggle Terminal (Snacks)" },
    { "<leader>ty", function() Snacks.terminal(nil, { cwd = vim.fn.expand("%:p:h") }) end, desc = "Terminal (cwd)" },
    
    -- Git keymaps
    --[[ { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" }, ]]
    --[[ { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" }, ]]
    --[[ { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File" }, ]]
    --[[ { "<leader>gl", function() Snacks.lazygit() end, desc = "Lazygit" }, ]]
    --[[ { "<leader>gL", function() Snacks.lazygit.log() end, desc = "Lazygit Log" }, ]]
    
    -- Notification history
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    
    -- File operations
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    
    -- Word highlighting toggle
    { "<leader>uw", function() Snacks.words.toggle() end, desc = "Toggle Word Highlights" },
    
    -- Scroll to top/bottom
    { "<leader>st", function() Snacks.scroll.to_top() end, desc = "Scroll to Top" },
    { "<leader>sb", function() Snacks.scroll.to_bottom() end, desc = "Scroll to Bottom" },
  },
}
