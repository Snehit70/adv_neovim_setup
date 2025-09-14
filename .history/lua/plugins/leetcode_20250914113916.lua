return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons", -- optional
  },

  opts = {
    -- Plugin configuration
    arg = "leetcode.nvim",
    lang = "python3",
    logging = true,
    image_support = false, -- disable to enable description wrap

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

    -- Language-specific code injection
    injector = {
      ["python3"] = {
        before = { "# Add any imports here" },
      },
      ["cpp"] = {
        before = { "#include <bits/stdc++.h>", "using namespace std;" },
        after = "int main() {}",
      },
      ["java"] = {
        before = "import java.util.*;",
      },
    },

    -- Console configuration
    console = {
      open_on_runcode = false,
      dir = "row", -- "col" | "row"
      size = {
        width = "50%",
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
      width = "45%",
      show_stats = true,
    },

    -- Event hooks
    hooks = {
      enter = {},
      leave = {},
      question_enter = {},
      question_leave = {},
    },

    -- Internal keybindings
    keys = {
      toggle = { "q" },
      confirm = { "<CR>" },
      reset_testcases = "r",
      use_testcase = "U",
      focus_testcases = "H",
      focus_result = "L",
    },

    -- Theme customization
    theme = {},
  },

  config = function(_, opts)
    require("leetcode").setup(opts)

    -- Custom keymaps
    local keymap_opts = { noremap = true, silent = true }
    
    vim.keymap.set("n", "<leader>lq", "<cmd>Leet<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Open Leetcode menu" }))
    
    vim.keymap.set("n", "<leader>ll", "<cmd>Leet list<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "List problems" }))
    
    vim.keymap.set("n", "<leader>lt", "<cmd>Leet test<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Test current solution" }))
    
    vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Submit current solution" }))
    
    vim.keymap.set("n", "<leader>lr", "<cmd>Leet run<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Run current solution" }))
    
    vim.keymap.set("n", "<leader>li", "<cmd>Leet info<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Show problem info" }))
    
    vim.keymap.set("n", "<leader>lc", "<cmd>Leet console<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Open console" }))
    
    vim.keymap.set("n", "<leader>ld", "<cmd>Leet desc<cr>", 
      vim.tbl_extend("force", keymap_opts, { desc = "Toggle description" }))
  end,
}
