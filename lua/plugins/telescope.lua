return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        -- Performance optimizations
        cache_picker = {
          num_pickers = 10,
          limit_entries = 1000,
        },
        
        -- UI improvements
        prompt_prefix = " 🔍 ",
        selection_caret = " ▶ ",
        entry_prefix = "   ",
        
        -- Layout configuration
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            width = 0.9,
            height = 0.8,
            preview_width = 0.6,
            prompt_position = "top",
          },
        },
        sorting_strategy = "ascending",
        winblend = 0,
        
        -- Performance settings
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        
        -- File ignore patterns for better performance
        file_ignore_patterns = {
          "^.git/",
          "^.svn/",
          "^.hg/",
          "^CVS/",
          "^.DS_Store",
          "^Thumbs.db",
          
          -- Dependencies and build artifacts
          "node_modules/",
          "npm-debug.log",
          "yarn-error.log",
          "package-lock.json",
          "yarn.lock",
          
          -- Python
          "__pycache__/",
          "%.pyc$",
          "%.pyo$",
          "%.pyd$",
          ".Python",
          "pip-log.txt",
          "pip-delete-this-directory.txt",
          ".venv/",
          "venv/",
          ".env",
          
          -- Rust
          "target/",
          "Cargo.lock",
          
          -- Go
          "go.sum",
          
          -- Java
          "%.class$",
          "%.jar$",
          "%.war$",
          "target/",
          
          -- C/C++
          "%.o$",
          "%.a$",
          "%.so$",
          "%.dylib$",
          "%.exe$",
          
          -- IDEs and editors
          ".vscode/",
          ".idea/",
          "%.swp$",
          "%.swo$",
          "*~",
          
          -- OS generated
          ".Trashes",
          "ehthumbs.db",
          "desktop.ini",
          
          -- Logs and temporary files
          "%.log$",
          "%.tmp$",
          "%.temp$",
        },
        
        -- Search configuration (with fallback if rg not available)
        vimgrep_arguments = vim.fn.executable("rg") == 1 and {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Search hidden files
          "--glob=!.git/*", -- But exclude .git
        } or nil,
      },
      
      pickers = {
        find_files = {
          hidden = true, -- Show hidden files
          follow = true, -- Follow symlinks
          -- Use fd if available for better performance, fallback to default find
          find_command = vim.fn.executable("fd") == 1
            and { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" }
            or nil,
        },
        
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob=!.git/*" }
          end,
        },
      },
    })
    
    -- Note: Keymaps are now handled by lazy.nvim 'keys' table above
  end,
}
