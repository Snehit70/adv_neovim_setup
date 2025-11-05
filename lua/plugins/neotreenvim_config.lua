return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- Optional image support
    -- "3rd/image.nvim",
  },
  opts = {
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    enable_modified_markers = true,
    enable_refresh_on_write = true,
    
    -- Multiple sources support
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    source_selector = {
      winbar = true,
      statusline = false,
      show_scrolled_off_parent_node = false,
      sources = {
        { source = "filesystem", display_name = " 󰉓 Files " },
        { source = "buffers", display_name = " 󰈚 Buffers " },
        { source = "git_status", display_name = " 󰊢 Git " },
        { source = "document_symbols", display_name = "  Symbols " },
      },
      content_layout = "start",
      tabs_layout = "equal",
      truncation_character = "…",
      tabs_min_width = nil,
      tabs_max_width = nil,
      padding = 0,
      separator = { left = "▏", right = "▕" },
      separator_active = nil,
      show_separator_on_edge = false,
      highlight_tab = "NeoTreeTabInactive",
      highlight_tab_active = "NeoTreeTabActive",
      highlight_background = "NeoTreeTabInactive",
      highlight_separator = "NeoTreeTabSeparatorInactive",
      highlight_separator_active = "NeoTreeTabSeparatorActive",
    },
    
    default_component_configs = {
      container = {
        enable_character_fade = true
      },
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        highlight = "NeoTreeIndentMarker",
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
      -- File size display
      file_size = {
        enabled = true,
        required_width = 64,
      },
      -- Last modified time
      type = {
        enabled = true,
        required_width = 122,
      },
      last_modified = {
        enabled = true,
        required_width = 88,
      },
      created = {
        enabled = false,
        required_width = 110,
      },
      symlink_target = {
        enabled = true,
      },
      -- Diagnostics display
      diagnostics = {
        symbols = {
          hint = "",
          info = "",
          warn = "",
          error = "",
        },
        highlights = {
          hint = "DiagnosticSignHint",
          info = "DiagnosticSignInfo",
          warn = "DiagnosticSignWarn",
          error = "DiagnosticSignError",
        },
      },
    },
    
    window = {
      position = "float",
      width = 40, -- Width for left/right positions
      height = 15,
      auto_expand_width = false,
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
        ["<space>"] = "none",
        
        -- Navigation
        ["h"] = "close_node",
        ["l"] = "open",
        ["<Tab>"] = "open",
        ["[g"] = "prev_git_modified",
        ["]g"] = "next_git_modified",
        ["[d"] = "prev_diagnostic",
        ["]d"] = "next_diagnostic",
        
        -- File operations
        ["a"] = {
          "add",
          config = {
            show_path = "none"
          }
        },
        ["A"] = "add_directory", 
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["c"] = "copy",
        ["m"] = "move",
        
        -- Utility
        ["."] = "set_root",
        ["H"] = "toggle_hidden",
        ["R"] = "refresh",
        ["?"] = "show_help",
        ["/"] = "fuzzy_finder",
        ["D"] = "fuzzy_finder_directory",
        ["#"] = "fuzzy_sorter",
        ["f"] = "filter_on_submit",
        ["<C-x>"] = "clear_filter",
        
        -- Opening modes
        ["<C-t>"] = "open_tabnew",
        ["<C-v>"] = "open_vsplit",
        ["<C-x>"] = "open_split",
        ["s"] = "open_split",
        ["v"] = "open_vsplit",
        ["t"] = "open_tabnew",
        
        -- Path operations
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
            vim.notify("Copied path: " .. path)
          end,
          desc = "Copy absolute path",
        },
        ["gy"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local relative_path = vim.fn.fnamemodify(path, ":~:.")
            vim.fn.setreg("+", relative_path, "c")
            vim.notify("Copied relative path: " .. relative_path)
          end,
          desc = "Copy relative path",
        },
        
        -- Preview
        ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
        
        -- Git operations
        ["gu"] = "git_unstage_file",
        ["ga"] = "git_add_file",
        ["gr"] = "git_revert_file",
        ["gc"] = "git_commit",
        ["gp"] = "git_push",
        ["gg"] = "git_commit_and_push",
        
        -- System operations
        ["o"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.jobstart({ "xdg-open", path }, { detach = true })
          end,
          desc = "Open with system default",
        },
        
        -- Telescope integration
        ["<C-f>"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").find_files({ cwd = vim.fn.fnamemodify(path, ":h") })
          end,
          desc = "Telescope find files",
        },
        ["<C-g>"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            require("telescope.builtin").live_grep({ cwd = vim.fn.fnamemodify(path, ":h") })
          end,
          desc = "Telescope live grep",
        },
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
        always_show = {
          ".gitignore",
          ".env.example",
        },
        never_show_by_pattern = {
          ".null-ls_*",
        },
      },
      
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      
      -- Performance optimizations
      async_directory_scan = "auto", -- "auto", "always", "never"
      scan_mode = "shallow", -- "shallow", "deep"
      use_libuv_file_watcher = true,
      bind_to_cwd = false,
      cwd_target = {
        sidebar = "tab",
        current = "window",
      },
      
      -- Better file handling
      group_empty_dirs = true, -- Group single child directories
      hijack_netrw_behavior = "open_current", -- Replace netrw
      
      -- Sorting options
      find_by_full_path_words = false,
      find_command = "fd",
      find_args = {
        fd = {
          "--exclude", ".git",
          "--exclude", "node_modules",
        }
      },
      
      -- Enhanced commands
      commands = {
        copy_selector = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local filename = node.name
          local modify = vim.fn.fnamemodify

          local results = {
            filepath,
            modify(filepath, ":."),
            modify(filepath, ":~"),
            filename,
            modify(filename, ":r"),
            modify(filename, ":e"),
          }

          vim.ui.select({
            "1. Absolute path: " .. results[1],
            "2. Path relative to CWD: " .. results[2],
            "3. Path relative to HOME: " .. results[3],
            "4. Filename: " .. results[4],
            "5. Filename without extension: " .. results[5],
            "6. Extension of the filename: " .. results[6],
          }, { prompt = "Choose to copy to clipboard:" }, function(choice)
            if choice then
              local i = tonumber(choice:sub(1, 1))
              if i then
                local result = results[i]
                vim.fn.setreg("+", result)
                vim.notify("Copied: " .. result)
              end
            end
          end)
        end,
        
        -- Open terminal in node directory
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          vim.fn.jobstart({ "xdg-open", path }, { detach = true })
        end,
      },
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          ["#"] = "fuzzy_sorter",
          ["f"] = "filter_on_submit",
          ["<C-x>"] = "clear_filter",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
          ["i"] = "show_file_details",
          ["o"] = "system_open",
          ["<c-c>"] = "copy_selector",
        },
        fuzzy_finder_mappings = {
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
        },
      },
    },
    
    buffers = {
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = true,
      show_unloaded = true,
      window = {
        mappings = {
          ["bd"] = "buffer_delete",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        }
      },
    },
    
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"]  = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
          ["o"] = { "show_help", nowait=false, config = { title = "Order by", prefix_key = "o" }},
          ["oc"] = { "order_by_created", nowait = false },
          ["od"] = { "order_by_diagnostics", nowait = false },
          ["om"] = { "order_by_modified", nowait = false },
          ["on"] = { "order_by_name", nowait = false },
          ["os"] = { "order_by_size", nowait = false },
          ["ot"] = { "order_by_type", nowait = false },
        }
      }
    },
    
    document_symbols = {
      follow_cursor = true,
      client_filters = "first",
      renderers = {
        root = {
          {"indent"},
          {"icon", default="C" },
          {"name", zindex = 10},
        },
        symbol = {
          {"indent", with_expanders = true},
          {"kind_icon", default="?" },
          {"container",
            content = {
              {"name", zindex = 10},
              {"kind_name", zindex = 20, align = "right"},
            }
          }
        },
      },
      window = {
        mappings = {
          ["<cr>"] = "jump",
          ["o"] = "jump",
          ["A"] = "noop",
          ["d"] = "noop",
          ["y"] = "noop",
          ["x"] = "noop",
          ["p"] = "noop",
          ["c"] = "noop",
          ["m"] = "noop",
          ["a"] = "noop",
          ["/"] = "filter",
          ["f"] = "filter_on_submit",
        },
      },
    },
    
    -- Renderer settings for custom appearance
    renderers = {
      directory = {
        {"indent"},
        {"icon"},
        {"current_filter"},
        {"name"},
        {"git_status"},
        {"diagnostics"},
        {"clipboard"},
      },
      file = {
        {"indent"},
        {"icon"},
        {"name", use_git_status_colors = true},
        {"git_status"},
        {"diagnostics"},
        {"file_size"},
        {"type"},
        {"last_modified"},
        {"created"},
        {"clipboard"},
      },
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
      {
        event = "file_added",
        handler = function(args)
          vim.notify("File created: " .. args, vim.log.levels.INFO)
        end
      },
      {
        event = "file_deleted",
        handler = function(args)
          vim.notify("File deleted: " .. args, vim.log.levels.WARN)
        end
      },
      {
        event = "file_renamed",
        handler = function(args)
          vim.notify("File renamed: " .. args.source .. " -> " .. args.destination, vim.log.levels.INFO)
        end
      },
      {
        event = "file_moved",
        handler = function(args)
          vim.notify("File moved: " .. args.source .. " -> " .. args.destination, vim.log.levels.INFO)
        end
      },
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true
        end
      },
    },
  },
  
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle File Explorer" },
    { "<leader>E", "<cmd>Neotree focus<cr>", desc = "Focus File Explorer" },
    { "<leader>ge", "<cmd>Neotree float git_status<cr>", desc = "Git Status" },
    { "<leader>be", "<cmd>Neotree toggle buffers<cr>", desc = "Buffer Explorer" },
    { "<leader>se", "<cmd>Neotree toggle document_symbols<cr>", desc = "Document Symbols" },
  },
}
