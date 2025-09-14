return {
  "nvim-telescope/telescope.nvim",
  lazy = false,
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
        
        -- Search configuration
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden", -- Search hidden files
          "--glob=!.git/*", -- But exclude .git
        },
      },
      
      pickers = {
        find_files = {
          hidden = true, -- Show hidden files
          follow = true, -- Follow symlinks
          -- Use fd if available for better performance
          find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
        },
        
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob=!.git/*" }
          end,
        },
      },
    })

    -- Keymaps for the pickers you actually use
    local keymap = vim.keymap.set
    local keymap_opts = { noremap = true, silent = true }
    
    -- Find files (your main picker)
    keymap("n", "<leader>ff", builtin.find_files, 
      vim.tbl_extend("force", keymap_opts, { desc = "Find files" }))
    
    -- Live grep (search text in files)
    keymap("n", "<leader>fg", builtin.live_grep, 
      vim.tbl_extend("force", keymap_opts, { desc = "Live grep" }))
    
    -- Nvim config files (your custom picker)
    keymap("n", "<leader>fr", function()
      builtin.find_files({
        prompt_title = "󰈔 Neovim Config Files",
        cwd = vim.fn.stdpath("config"),
        hidden = true,
        follow = true,
        file_ignore_patterns = { ".git/" }, -- Only ignore .git in config
      })
    end, vim.tbl_extend("force", keymap_opts, { desc = "Nvim config files" }))
  end,
}
