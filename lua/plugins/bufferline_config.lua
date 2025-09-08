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
        style_preset = "padded_slant",
        numbers = "ordinal",
        close_command = "bdelete! %d",
        right_mouse_command = nil, -- Disabled: No action for right-click.
        left_mouse_command = nil,  -- Disabled: No action for left-click.
        middle_mouse_command = nil, -- Disabled: No action for middle-click.
        indicator = {
          icon = "▎", -- Thin vertical bar icon.
          style = "underline", -- Underlines the active buffer's name.
        },
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "<", -- Indicator for truncated buffers on the left.
        right_trunc_marker = ">", -- Indicator for truncated buffers on the right.
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        offsets = {
          {
            filetype = "neo-tree", -- Applies to Neo-tree window.
            text = "Neo-tree",     -- Text to display.
            highlight = "Directory", -- Highlight group for the text.
            text_align = "left",   -- Text alignment.
            separator = true,      -- Displays a separator after this offset.
          },
          {
            filetype = "NvimTree",   -- Applies to NvimTree window.
            text = "File Explorer",  -- Text to display.
            highlight = "Directory", -- Highlight group for the text.
            text_align = "left",   -- Text alignment.
            separator = true,      -- Displays a separator after this offset.
          },
        },

        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_buffer_close_icons_if_not_selected = true,
        show_close_icon = true,
        show_tab_indicators = true,
        max_name_length = 20, -- Maximum length of buffer names
        persist_buffer_sort = true,
        separator_style = "thin",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true, -- Enables hover.
          delay = 100,    -- Short delay before hover info appears.
          reveal = { "close" }, -- Reveals the close icon on hover.
        },
        sort_by = "id",
        name_formatter = function(buf)
          if buf.name:match("%.md$") then
            return vim.fn.fnamemodify(buf.name, ":t:r")
          end
          return vim.fn.fnamemodify(buf.name, ":t")
        end,
      },
    }
  end,

  -- Keybindings for bufferline actions.
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    { "<leader>bc", "<cmd>bdelete<cr>", desc = "Close current buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
  },
}
