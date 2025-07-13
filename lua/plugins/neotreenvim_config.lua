return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        default = "󰈚",
        highlight = "NeoTreeFileIcon"
      },
      modified = {
        symbol = "●",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = "NeoTreeFileName",
      },
      git_status = {
        symbols = {
          added     = "✚",
          modified  = "",
          deleted   = "✖",
          renamed   = "󰁕",
          untracked = "",
          ignored   = "",
          unstaged  = "󰄱",
          staged    = "",
          conflict  = "",
        }
      },
    },
    
    window = {
      position = "float",
      max_width = 120,
      max_height = 40,
      popup = {
        size = {
          height = "80%",
          width = "60%",
        },
        position = "50%",
      },
      mappings = {
        ["<cr>"] = "open",
        ["<esc>"] = "cancel",
        ["h"] = "close_node",
        ["a"] = "add",
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["R"] = "refresh",
        ["q"] = "close_window",
        ["?"] = "show_help",
        ["<C-t>"] = "open_tabnew",
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
      }
    },
    
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          "node_modules",
          ".DS_Store",
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      use_libuv_file_watcher = true,
      bind_to_cwd = false,
    },
    
    git_status = {
      window = {
        position = "float",
      }
    },
    
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end
      },
    },
  },
  
  keys = {
    {"<leader>e","<cmd>Neotree toggle<cr>",desc = "Float Explorer"},
  },
}
