return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      mode = "buffers",
      style_preset = "minimal", -- Changed from padded_slant for cleaner look
      numbers = "ordinal",
      
      -- Simple indicator styling
      indicator = {
        icon = "▎",
        style = "icon", -- Changed from underline for cleaner look
      },
      
      -- Essential icons only
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      
      -- LSP integration
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      
      -- File explorer integration
      offsets = {
        {
          filetype = "neo-tree",
          text = "󰙅 Explorer",
          highlight = "Directory",
          text_align = "left",
          separator = true,
        },
      },
      
      -- Simplified display options
      show_buffer_icons = true,
      show_buffer_close_icons = false, -- Cleaner without close icons
      show_close_icon = false,
      show_tab_indicators = true,
      max_name_length = 25,
      
      -- Clean separator
      separator_style = "thick", -- More visible than thin
      always_show_bufferline = true,
      
      -- Custom name formatter for cleaner names
      name_formatter = function(buf)
        -- Remove extension for markdown files
        if buf.name:match("%.md$") then
          return vim.fn.fnamemodify(buf.name, ":t:r")
        end
        -- Show just filename for others
        return vim.fn.fnamemodify(buf.name, ":t")
      end,
      
      -- Sort by buffer ID for consistent order
      sort_by = "id",
    },
  },

  keys = {
    -- Basic navigation (keep these)
    { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous buffer" },
    
    -- Buffer management (matching your which-key config)
    { "<leader>bc", "<cmd>bdelete<cr>", desc = "Close current buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
  },
}
