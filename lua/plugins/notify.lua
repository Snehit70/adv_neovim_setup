return {
  "rcarriga/nvim-notify",
  keys = {
    {
      "<leader>un",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss all Notifications",
    },
  },
  opts = function()
    -- Get background color dynamically from colorscheme
    local bg_color = "#000000" -- fallback
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "Normal", link = false })
    if ok and hl.bg then
      bg_color = string.format("#%06x", hl.bg)
    end

    return {
      background_colour = bg_color,
      timeout = 2000,
      max_height = function()
        return math.floor(vim.o.lines * 0.3)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.3)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      render = "minimal",
      stages = "fade",
    }
  end,
}
