return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  lazy = vim.fn.argv(0, -1) ~= "leetcode.nvim", -- Optimized lazy loading
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional
    "3rd/image.nvim", -- optional image support
  },
  cmd = "Leet", -- Enable lazy loading via command

  opts = {
    -- Plugin configuration
    arg = "leetcode.nvim",
    lang = "cpp",
    logging = true,
    image_support = true, -- disable to enable description wrap

    -- LeetCode China configuration
    cn = {
      enabled = false,
      translator = true,
      translate_problems = true,
    },

    -- Storage paths
    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },

    -- Plugin behavior
    plugins = {
      non_standalone = false,
    },

    -- Cache settings
    cache = {
      update_interval = 60 * 60 * 24 * 7, -- 7 days
    },

    -- Editor configuration
    editor = {
      reset_previous_code = true, -- Reset code to default when switching
      fold_imports = true, -- Auto-fold imports for cleaner view
    },

    -- Language-specific code injection
    injector = {
      ["python3"] = {
        imports = function(default_imports)
          -- Extend default imports with custom ones
          vim.list_extend(default_imports, {
            "from typing import List, Optional, Dict, Set, Tuple",
            "from collections import defaultdict, Counter, deque",
            "import heapq",
            "import bisect",
            "import math",
          })
          return default_imports
        end,
        after = {
          "",
          "# Test code (not submitted)",
          "if __name__ == '__main__':",
          "    pass",
        },
      },
      ["cpp"] = {
        imports = function()
          return {
            "#include <bits/stdc++.h>",
            "using namespace std;",
          }
        end,
        after = {
          "",
          "// Test code (not submitted)",
          "int main() {",
          "    return 0;",
          "}",
        },
      },
      ["java"] = {
        imports = function(default_imports)
          vim.list_extend(default_imports, {
            "import java.util.*;",
            "import java.util.stream.*;",
          })
          return default_imports
        end,
      },
      ["javascript"] = {
        after = {
          "",
          "// Test code (not submitted)",
          "// const obj = new Solution();",
        },
      },
      ["typescript"] = {
        after = {
          "",
          "// Test code (not submitted)",
          "// const obj = new Solution();",
        },
      },
      ["rust"] = {
        after = {
          "",
          "// Test code (not submitted)",
          "// fn main() {}",
        },
      },
      ["go"] = {
        after = {
          "",
          "// Test code (not submitted)",
          "// func main() {}",
        },
      },
    },

    -- Console configuration
    console = {
      open_on_runcode = true, -- Auto-open console when running code
      dir = "row", -- "col" | "row"
      size = {
        width = "90%", -- Wider for better visibility
        height = "75%",
      },
      result = {
        size = "60%",
      },
      testcase = {
        virt_text = true,
        size = "40%",
      },
    },

    -- Problem description panel
    description = {
      position = "left", -- "left" | "right" | "top" | "bottom"
      width = "40%", -- Optimized width for better readability
      show_stats = true,
    },

    -- Event hooks for automation
    hooks = {
      ["enter"] = {
        function()
          -- Custom actions when entering leetcode.nvim
          vim.notify("LeetCode.nvim loaded!", vim.log.levels.INFO)
        end,
      },
      ["leave"] = {},
      ["question_enter"] = {
        function()
          -- Auto-save when switching questions
          vim.cmd("silent! write")
        end,
      },
      ["question_leave"] = {},
    },

    -- Internal keybindings (within leetcode windows)
    keys = {
      toggle = { "q", "<Esc>" }, -- Multiple keys for easier closing
      confirm = { "<CR>" },
      reset_testcases = "r",
      use_testcase = "U",
      focus_testcases = "H",
      focus_result = "L",
    },

    -- Theme customization for better aesthetics
    theme = {
      ["alt"] = {
        bg = "NONE", -- Transparent background
      },
      ["normal"] = {
        fg = "#98c379", -- Soft green for normal text
      },
      ["easy"] = {
        fg = "#5cb85c", -- Green for easy problems
      },
      ["medium"] = {
        fg = "#f0ad4e", -- Orange for medium problems
      },
      ["hard"] = {
        fg = "#d9534f", -- Red for hard problems
      },
    },
  },

  config = function(_, opts)
    require("leetcode").setup(opts)

    -- Custom keymaps with better organization
    local keymap_opts = { noremap = true, silent = true }
    
    -- Main menu
    vim.keymap.set("n", "<leader>lq", "<cmd>Leet<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "LeetCode Menu" }))
    
    -- Problem navigation
    vim.keymap.set("n", "<leader>ll", "<cmd>Leet list<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "List Problems" }))
    vim.keymap.set("n", "<leader>ltb", "<cmd>Leet tabs<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Open Tabs" }))
    vim.keymap.set("n", "<leader>lrn", "<cmd>Leet random<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Random Problem" }))
    vim.keymap.set("n", "<leader>ldy", "<cmd>Leet daily<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Daily Problem" }))
    
    -- Code execution
    vim.keymap.set("n", "<leader>lr", "<cmd>Leet run<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Run Solution" }))
    vim.keymap.set("n", "<leader>lt", "<cmd>Leet test<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Test Solution" }))
    vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Submit Solution" }))
    
    -- Information & utilities
    vim.keymap.set("n", "<leader>li", "<cmd>Leet info<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Problem Info" }))
    vim.keymap.set("n", "<leader>lc", "<cmd>Leet console<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Open Console" }))
    vim.keymap.set("n", "<leader>ld", "<cmd>Leet desc<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Toggle Description" }))
    vim.keymap.set("n", "<leader>ldt", "<cmd>Leet desc toggle<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Toggle Description Stats" }))
    
    -- Code management
    vim.keymap.set("n", "<leader>ly", "<cmd>Leet yank<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Yank Code" }))
    vim.keymap.set("n", "<leader>lrst", "<cmd>Leet reset<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Reset Code" }))
    vim.keymap.set("n", "<leader>llst", "<cmd>Leet last_submit<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Last Submission" }))
    vim.keymap.set("n", "<leader>linj", "<cmd>Leet inject<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Re-inject Code" }))
    
    -- Language & layout
    vim.keymap.set("n", "<leader>llg", "<cmd>Leet lang<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Change Language" }))
    vim.keymap.set("n", "<leader>lrs", "<cmd>Leet restore<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Restore Layout" }))
    
    -- Browser integration
    vim.keymap.set("n", "<leader>lo", "<cmd>Leet open<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Open in Browser" }))
    
    -- Session management
    vim.keymap.set("n", "<leader>lx", "<cmd>Leet exit<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Exit LeetCode" }))
    
    -- Cache management
    vim.keymap.set("n", "<leader>lcu", "<cmd>Leet cache update<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Update Cache" }))
    
    -- Quick filters for listing problems
    vim.keymap.set("n", "<leader>lle", "<cmd>Leet list difficulty=easy<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "List Easy Problems" }))
    vim.keymap.set("n", "<leader>llm", "<cmd>Leet list difficulty=medium<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "List Medium Problems" }))
    vim.keymap.set("n", "<leader>llh", "<cmd>Leet list difficulty=hard<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "List Hard Problems" }))
    
    -- Auto-commands for LeetCode buffers
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "leetcode",
      callback = function()
        -- Set local options for better coding experience
        vim.opt_local.number = true
        vim.opt_local.relativenumber = true
        vim.opt_local.wrap = false
        vim.opt_local.cursorline = true
        
        -- Quick save on leaving insert mode
        vim.api.nvim_create_autocmd("InsertLeave", {
          buffer = 0,
          callback = function()
            vim.cmd("silent! write")
          end,
        })
      end,
    })
  end,
}
