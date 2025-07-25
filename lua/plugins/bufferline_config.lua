-- This file configures the 'bufferline.nvim' plugin.
-- bufferline.nvim provides a highly customizable bufferline (or tabline) at the top of your editor.
-- It displays open buffers, allows for quick navigation, visual indication of modified files,
-- and integrates with LSP diagnostics.

return {
  "akinsho/bufferline.nvim",
  -- Load the plugin very late in the startup process to ensure other essential plugins are in place.
  event = "VeryLazy",
  -- Use any version of the plugin.
  version = "*",
  -- Declare dependencies: nvim-web-devicons provides file type icons for the bufferline.
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  -- The 'opts' function returns the configuration table for bufferline.nvim.
  opts = function()
    return {
      options = {
        -- mode: Defines what the bufferline displays.
        -- 'buffers': Displays all open buffers.
        mode = "buffers",

        -- style_preset: Sets the visual style of the bufferline.
        -- 'padded_slant': Uses a slanted separator with padding, providing a clean look.
        style_preset = "padded_slant",

        -- numbers: How buffer numbers are displayed.
        -- 'ordinal': Displays buffer numbers as ordinal numbers (1, 2, 3, etc.).
        numbers = "ordinal",

        -- close_command: Command executed when a buffer's close icon is clicked.
        -- 'bdelete! %d': Closes the buffer using 'bdelete!', which allows closing modified buffers.
        -- '%d' is a placeholder for the buffer number.
        close_command = "bdelete! %d",

        -- Mouse commands: Define actions for mouse clicks on buffers in the bufferline.
        -- Currently, all mouse commands are disabled as per user preference.
        right_mouse_command = nil, -- Disabled: No action for right-click.
        left_mouse_command = nil,  -- Disabled: No action for left-click.
        middle_mouse_command = nil, -- Disabled: No action for middle-click.

        -- indicator: Visual indicator for the currently active buffer.
        indicator = {
          icon = "▎", -- Thin vertical bar icon.
          style = "underline", -- Underlines the active buffer's name.
        },

        -- buffer_close_icon: Icon displayed on each individual buffer to close it.
        buffer_close_icon = "󰅖",

        -- modified_icon: Icon displayed next to a buffer name if the file has unsaved changes.
        modified_icon = "●",

        -- close_icon: Icon for the overall bufferline close button (if enabled).
        close_icon = "",

        -- Truncation markers: Icons displayed if bufferline content is truncated (too many buffers).
        left_trunc_marker = "<", -- Indicator for truncated buffers on the left.
        right_trunc_marker = ">", -- Indicator for truncated buffers on the right.

        -- diagnostics: Integrates with Neovim's built-in LSP client to display diagnostic info.
        -- 'nvim_lsp': Uses LSP diagnostics.
        diagnostics = "nvim_lsp",

        -- diagnostics_update_in_insert: Controls whether diagnostics update in Insert mode.
        -- 'false': Prevents diagnostics from updating in Insert mode to avoid distractions.
        diagnostics_update_in_insert = false,

        -- offsets: Defines custom sections that appear on the left side of the bufferline.
        -- Often used for file explorers or other persistent windows.
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

        -- show_buffer_icons: Displays file type icons next to buffer names.
        show_buffer_icons = true,

        -- show_buffer_close_icons: Displays the close icon on each individual buffer.
        show_buffer_close_icons = true,

        -- show_buffer_close_icons_if_not_selected: Controls when individual close icons are shown.
        -- 'true': Only shows the close icon on the currently selected (active) buffer.
        -- This reduces visual clutter.
        show_buffer_close_icons_if_not_selected = true,

        -- show_close_icon: Displays a general close icon for the bufferline.
        show_close_icon = true,

        -- show_tab_indicators: Shows indicators for tabs (if 'mode' was set to "tabs").
        show_tab_indicators = true,

        -- max_name_length: Maximum length of the buffer name displayed in the bufferline.
        -- If a name exceeds this, it will be truncated, saving space.
        max_name_length = 20, -- Maximum length of buffer names

        -- persist_buffer_sort: If true, the custom sorting order of buffers will persist across sessions.
        persist_buffer_sort = true,

        -- separator_style: Visual style of the separators between buffers.
        -- 'thin': Uses a thin vertical line for a minimalist look.
        separator_style = "thin",

        -- enforce_regular_tabs: If true, enforces a strict tab-like behavior for buffers.
        enforce_regular_tabs = false,

        -- always_show_bufferline: Controls whether the bufferline is always visible.
        -- 'true': The bufferline is always present, even with one buffer.
        always_show_bufferline = true,

        -- hover: Configuration for hover functionality on bufferline items.
        hover = {
          enabled = true, -- Enables hover.
          delay = 100,    -- Short delay before hover info appears.
          reveal = { "close" }, -- Reveals the close icon on hover.
        },

        -- sort_by: Controls the order in which buffers are displayed.
        -- 'id': Sorts buffers by their internal Neovim buffer ID, providing a stable and predictable order.
        sort_by = "id",

        -- name_formatter: A custom function to format buffer names.
        -- If the buffer is a Markdown file (.md), it returns the filename without the extension.
        -- Otherwise, it returns the full filename.
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
    -- <Tab>: Cycles to the next buffer.
    -- Uses the command-line command, which might cause rapid cycling if held down.
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    -- <S-Tab>: Cycles to the previous buffer.
    -- Uses the command-line command, which might cause rapid cycling if held down.
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    -- <leader>bp: Opens a picker to select a buffer.
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
    -- <leader>bc: Closes the current buffer.
    { "<leader>bc", "<cmd>bdelete<cr>", desc = "Close current buffer" },
    -- <leader>bo: Closes all other buffers except the current one.
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    -- <leader>br: Closes all buffers to the right of the current one.
    { "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
    -- <leader>bl: Closes all buffers to the left of the current one.
    { "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
  },
}
