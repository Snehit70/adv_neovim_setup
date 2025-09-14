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
      popup = {
        size = {
          height = "85%", -- Slightly larger for better usability
          width = "65%",
        },
        position = "50%", -- Centered
      },
      mappings = {
        ["<cr>"] = "open",
        ["<esc>"] = "cancel",
        ["q"] = "close_window",
        
        -- Navigation
        ["h"] = "close_node",
        ["l"] = "open",
        ["<Tab>"] = "open",
        
        -- File operations (simple ones you might use)
        ["a"] = "add",
        ["A"] = "add_directory", 
        ["d"] = "delete",
        ["r"] = "rename",
        ["R"] = "refresh",
        
        -- Utility
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["?"] = "show_help",
        ["<C-t>"] = "open_tabnew",
        ["<C-v>"] = "open_vsplit",
        ["<C-x>"] = "open_split",
      }
    },
    
    filesystem = {
      -- Enhanced ignore patterns (matching your telescope config)
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true, -- Hide git ignored files by default
        hide_by_name = {
          -- Dependencies and build artifacts
          "node_modules",
          "npm-debug.log",
          "yarn-error.log",
          "package-lock.json",
          "yarn.lock",
          
          -- Python
          "__pycache__",
          ".pytest_cache",
          ".venv",
          "venv",
          ".env",
          "*.pyc",
          "*.pyo",
          "*.pyd",
          
          -- Rust
          "target",
          "Cargo.lock",
          
          -- Go
          "go.sum",
          
          -- Java
          "*.class",
          "*.jar",
          "*.war",
          
          -- C/C++
          "*.o",
          "*.a",
          "*.so",
          "*.dylib",
          "*.exe",
          
          -- IDEs and editors
          ".vscode",
          ".idea",
          "*.swp",
          "*.swo",
          
          -- OS generated
          ".DS_Store",
          "Thumbs.db",
          "desktop.ini",
          ".Trashes",
          
          -- Logs and temporary
          "*.log",
          "*.tmp",
          "*.temp",
        },
        hide_by_pattern = {
          "*.git/*",
          "*/node_modules/*",
          "*/__pycache__/*",
          "*/target/*",
          "*/.venv/*",
          "*/venv/*",
        },
        never_show = {
          ".DS_Store",
          "thumbs.db"
        },
      },
      
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      
      -- Performance optimizations
      use_libuv_file_watcher = true,
      bind_to_cwd = false,
      
      -- Better file handling
      group_empty_dirs = true, -- Group single child directories
      hijack_netrw_behavior = "open_current", -- Replace netrw
    },
    
    git_status = {
      window = {
        position = "float",
      }
    },
    
    -- Enhanced event handlers
    event_handlers = {
      {
        event = "file_open_requested",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end
      },
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end
      },
    },
  },
  
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    { "<leader>E", "<cmd>Neotree focus<cr>", desc = "Focus file explorer" },
  },
}
