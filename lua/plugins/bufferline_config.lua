-- ~/.config/nvim/lua/plugins/bufferline_config.lua
return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    return {
      options = {
        mode = "buffers",
        style_preset = "default", -- Don't access bufferline module here
        numbers = "ordinal",
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = "▎",
          style = "underline",
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        offsets = {
          {
            filetype = "neo-tree",
            text = "Neo-tree",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            separator = true,
          },
        },
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = "slant",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 150,
          reveal = { "close" },
        },
        sort_by = "insert_after_current",
        name_formatter = function(buf)
          if buf.name:match("%.md$") then
            return vim.fn.fnamemodify(buf.name, ":t:r")
          end
          return vim.fn.fnamemodify(buf.name, ":t")
        end,
      },
    }
  end,
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    { "<leader>bc", "<cmd>bdelete<cr>", desc = "Close current buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
    { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5" },
  },
}
