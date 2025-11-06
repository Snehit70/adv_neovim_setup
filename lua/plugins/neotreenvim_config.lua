return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle File Explorer" },
    { "<leader>E", "<cmd>Neotree focus<cr>", desc = "Focus File Explorer" },
  },
  opts = {
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_diagnostics = true,
    
    default_component_configs = {
      indent = {
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        expander_collapsed = "",
        expander_expanded = "",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
        default = "",
      },
    },
    
    window = {
      position = "float",
      popup = {
        size = { height = "80%", width = "50%" },
        position = "50%",
      },
      mappings = {
        ["<cr>"] = "open",
        ["<esc>"] = "cancel",
        ["q"] = "close_window",
        ["a"] = "add",
        ["d"] = "delete",
        ["r"] = "rename",
        ["H"] = "toggle_hidden",
        ["?"] = "show_help",
      },
    },
    
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          "node_modules",
          ".git",
          "__pycache__",
          ".DS_Store",
        },
      },
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
        },
      },
    },
    
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
