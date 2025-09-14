return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    arg = "leetcode.nvim",
    lang = "python3", -- default language
    cn = { -- leetcode.cn
      enabled = false, -- true if you want to use leetcode.cn instead of leetcode.com
      translator = true,
      translate_problems = true,
    },
    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },
    plugins = {
      non_standalone = false,
    },
    logging = true,
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
    cache = {
      update_interval = 60 * 60 * 24 * 7, -- 7 days
    },
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
    description = {
      position = "left", -- "left" | "right" | "top" | "bottom"
      width = "40%",
      show_stats = true,
    },
    hooks = {
      enter = {},
      leave = {},
      question_enter = {},
      question_leave = {},
    },
    keys = {
      toggle = { "q" },
      confirm = { "<CR>" },

      reset_testcases = "r",
      use_testcase = "U",
      focus_testcases = "H",
      focus_result = "L",
    },
    theme = {},
    image_support = false, -- setting this to `true` will disable question description wrap
  },
  config = function(_, opts)
    require("leetcode").setup(opts)

    -- Key mappings
    vim.keymap.set("n", "<leader>lq", "<cmd>Leet<cr>", { desc = "Open Leetcode menu" })
    vim.keymap.set("n", "<leader>ll", "<cmd>Leet list<cr>", { desc = "List problems" })
    vim.keymap.set("n", "<leader>lt", "<cmd>Leet test<cr>", { desc = "Test current solution" })
    vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<cr>", { desc = "Submit current solution" })
    vim.keymap.set("n", "<leader>lr", "<cmd>Leet run<cr>", { desc = "Run current solution" })
    vim.keymap.set("n", "<leader>li", "<cmd>Leet info<cr>", { desc = "Show problem info" })
    vim.keymap.set("n", "<leader>lc", "<cmd>Leet console<cr>", { desc = "Open console" })
    vim.keymap.set("n", "<leader>ld", "<cmd>Leet desc<cr>", { desc = "Toggle description" })
  end,
}

