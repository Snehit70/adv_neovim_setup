return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Enhanced notifications
    notifier = {
      enabled = true,
      timeout = 2000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- Style the notifications
      style = "compact", -- or "fancy"
      top_down = true, -- show notifications from top down 
    },

    -- Git enhancements
    git = {
      enabled = true,
    },
    
    gitbrowse = {
      enabled = true,
    },


    -- Additional useful features
    
    statuscolumn = {
      enabled = true, -- enhanced status column
    },

    words = {
      enabled = true, -- highlight word under cursor
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
    -- Notification history
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
  },
}
