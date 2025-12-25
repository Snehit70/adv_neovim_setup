return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- Optional: for better notifications
  },
  config = function()
    local ok, noice = pcall(require, "noice")
    if not ok then
      vim.notify("noice.nvim not found!", vim.log.levels.ERROR)
      return
    end

    noice.setup({
      -- Focus on floating command line (what you want)
      cmdline = {
        enabled = true,
        view = "cmdline_popup", -- Floating popup instead of bottom line
        opts = {
          -- Command line popup styling
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          position = {
            row = "50%", -- Center vertically
            col = "50%", -- Center horizontally
          },
          size = {
            width = "auto",
            height = "auto",
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        format = {
          -- Customize command formatting
          cmdline = { pattern = "^:", icon = " ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = "^:%s*lua%s+", icon = " ", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "󰘥" },
        },
      },

      -- Enhanced search popup
      messages = {
        enabled = true,
        view = "notify", -- Use notify for messages
        view_error = "notify",
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext", -- Keep search results inline
      },

      -- Popup menu for completion
      popupmenu = {
        enabled = true,
        backend = "nui", -- Use nui for better styling
        kind_icons = {}, -- Use default icons
      },

      -- Don't override these (keep default behavior)
      redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      },

      -- Minimal configuration - focus on command line
      notify = {
        enabled = true,
        view = "notify",
      },

      lsp = {
        -- Override markdown rendering for hover docs
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        signature = {
          enabled = false, -- Keep LSP signature help default
        },
        hover = {
          enabled = false, -- Keep LSP hover default (you don't use anyway)
        },
      },

      -- Presets for common configurations
      presets = {
        bottom_search = false, -- Use floating search popup
        command_palette = false, -- Don't use command palette (not what you want)
        long_message_to_split = true, -- Long messages go to split
        inc_rename = false, -- Disable inc-rename integration
        lsp_doc_border = true, -- Add border to LSP docs
      },

      -- Routes to control message handling (filter noisy messages)
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true }, -- Skip "file written" messages
        },
        {
          filter = {
            event = "msg_show",
            find = "search hit BOTTOM",
          },
          opts = { skip = true }, -- Skip search wrap messages
        },
        {
          filter = {
            event = "msg_show",
            find = "search hit TOP",
          },
          opts = { skip = true }, -- Skip search wrap messages
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "more line",
          },
          opts = { skip = true }, -- Skip "X more lines" messages
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "fewer line",
          },
          opts = { skip = true }, -- Skip "X fewer lines" messages
        },
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "yanked",
          },
          opts = { skip = true }, -- Skip yank messages
        },
        {
          -- Skip LSP progress spam
          filter = {
            event = "lsp",
            kind = "progress",
            cond = function(message)
              local client = vim.tbl_get(message.opts, "progress", "client")
              -- Skip noisy LSP progress from specific servers
              return client == "null-ls" or client == "copilot"
            end,
          },
          opts = { skip = true },
        },
      },
    })
  end,
}
