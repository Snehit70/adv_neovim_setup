return {
  "kawre/leetcode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    -- Enhanced picker with better performance
    {
      "nvim-telescope/telescope.nvim",
      optional = true,
    },
    {
      "nvim-treesitter/nvim-treesitter", 
      build = ":TSUpdate",
    },
  },
  build = ":TSUpdate html",
  cmd = "Leet",
  
  opts = {
    -- Core configuration
    arg = "leetcode.nvim",
    lang = "python3",
    logging = true,
    
    -- Disable leetcode.cn for global access
    cn = { 
      enabled = false 
    },
    
    -- Optimized storage paths
    storage = {
      home = vim.fn.stdpath("data") .. "/leetcode",
      cache = vim.fn.stdpath("cache") .. "/leetcode",
    },
    
    -- Enhanced plugin behavior
    plugins = {
      non_standalone = false, -- Can be toggled for dashboard integration
    },
    
    -- Aggressive caching for performance (demo feature)
    cache = {
      update_interval = 60 * 60 * 24 * 3, -- Update every 3 days for freshness
    },
    
    -- Advanced picker with fuzzy search
    picker = {
      provider = "telescope", -- Auto-fallback enabled
    },
    
    -- Disable heavy features for speed
    image_support = false,
    
    -- Clean editor (no imports, no folding)
    editor = {
      reset_previous_code = true,
      fold_imports = false,
    },
    
    -- ZERO IMPORTS - Clean templates
    injector = {
      ["python3"] = {
        before = false,
        imports = function(default_imports)
          return {} -- Completely empty
        end,
        template = [[
# @leet start
class Solution:
    def ${func_name}(self${func_args}) -> ${return_type}:
        ${cursor}
# @leet end
        ]],
      },
    },
    
    -- Enhanced console (demo-style layout)
    console = {
      open_on_runcode = true,
      dir = "row", -- Horizontal layout like demo
      size = {
        width = "95%", -- Wider for better view
        height = "80%", -- Taller for more content
      },
      result = {
        size = "55%", -- Balanced split
      },
      testcase = {
        virt_text = true, -- Show test case indicators
        size = "45%",
      },
    },
    
    -- Optimized description panel
    description = {
      position = "left",
      width = "45%", -- Slightly wider for better readability
      show_stats = true,
    },
    
    -- Advanced hooks with session management
    hooks = {
      enter = {
        function()
          vim.notify("🚀 LeetCode session started", vim.log.levels.INFO)
          -- Auto-update cache on entry if stale
          vim.schedule(function()
            vim.cmd("Leet cache update")
          end)
        end,
      },
      
      question_enter = {
        function(question)
          -- Enhanced environment setup
          vim.diagnostic.disable(0)
          
          -- Auto-cleanup any stray imports
          vim.schedule(function()
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            local clean_lines = {}
            local skip_line = false
            
            for _, line in ipairs(lines) do
              if line:match("^# @leet imports start") then
                skip_line = true
              elseif line:match("^# @leet imports end") then
                skip_line = false
              elseif not skip_line and not line:match("^from .* import") and not line:match("^import ") then
                table.insert(clean_lines, line)
              end
            end
            
            if #clean_lines < #lines then
              vim.api.nvim_buf_set_lines(0, 0, -1, false, clean_lines)
            end
          end)
          
          -- Enhanced buffer-local keymaps
          local opts = { buffer = 0, silent = true }
          
          -- Panel navigation
          vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
          vim.keymap.set('n', '<C-l>', '<C-w>l', opts) 
          vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
          vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
          
          -- Quick actions
          vim.keymap.set('n', '<leader>tr', '<cmd>Leet test<cr>', opts)
          vim.keymap.set('n', '<leader>ts', '<cmd>Leet submit<cr>', opts)
          vim.keymap.set('n', '<leader>tc', '<cmd>Leet console<cr>', opts)
          
          -- Enhanced help system
          vim.keymap.set('n', '<leader>?', function()
            vim.notify(string.format([[
🎯 LeetCode Pro Navigation | Problem: %s
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🖱️  Panel Navigation:
   <C-hjkl>     Navigate panels smoothly
   <C-w>w       Cycle through windows
   
⚡ Quick Actions (Buffer Local):
   <leader>tr   🧪 Test solution
   <leader>ts   📤 Submit solution  
   <leader>tc   💻 Toggle console
   
🎮 Console Controls:
   H            Focus testcases
   L            Focus results
   1,2,3...     Switch test cases
   U            Use current test case
   r            Reset test cases
   q/<Esc>      Close console
   
💡 Pro Tips:
   • Use telescope fuzzy search in problem list
   • Test multiple cases before submitting
   • Check constraints section carefully
            ]], question.title or "Unknown"), vim.log.levels.INFO, { 
              title = "🎯 LeetCode Pro Mode" 
            })
          end, opts)
          
          -- Status line enhancement
          vim.notify(string.format("📝 Opened: %s | %s", 
            question.title or "Problem", 
            question.difficulty or "Unknown"
          ), vim.log.levels.INFO)
        end,
      },
      
      leave = {
        function()
          vim.diagnostic.enable(0)
          vim.notify("👋 LeetCode session ended", vim.log.levels.INFO)
        end,
      },
    },
    
    -- Enhanced UI controls (demo-style)
    keys = {
      toggle = { "q", "<Esc>", "Q" }, -- Multiple exit options
      confirm = { "<CR>", "<Space>" }, -- Space for quick confirm
      reset_testcases = "r",
      use_testcase = "U", 
      focus_testcases = "H",
      focus_result = "L",
    },
    
    -- Premium theme (demo-inspired)
    theme = {
      -- Enhanced contrast and readability
      ["normal"] = {
        fg = "#abb2bf", -- Soft white
      },
      ["alt"] = {
        bg = "NONE", -- Transparent
      },
      -- Problem difficulty colors
      ["easy"] = {
        fg = "#98c379", -- Green
        bold = true,
      },
      ["medium"] = {
        fg = "#e5c07b", -- Yellow
        bold = true,
      },
      ["hard"] = {
        fg = "#e06c75", -- Red  
        bold = true,
      },
      -- Active elements
      ["testcase_active"] = {
        fg = "#61afef", -- Blue
        bold = true,
        bg = "#2c323c", -- Subtle highlight
      },
      ["result_success"] = {
        fg = "#98c379", -- Green
        bold = true,
      },
      ["result_failure"] = {
        fg = "#e06c75", -- Red
        bold = true,
      },
    },
  },
  
  -- Comprehensive keybinding system (demo-inspired)
  keys = {
    -- === CORE FUNCTIONS ===
    { "<leader>lq", "<cmd>Leet<cr>", desc = "🚀 Open LeetCode" },
    { "<leader>le", "<cmd>Leet exit<cr>", desc = "🚪 Exit LeetCode" },
    
    -- === PROBLEM DISCOVERY ===
    { "<leader>ll", "<cmd>Leet list<cr>", desc = "📋 Browse Problems" },
    { "<leader>ld", "<cmd>Leet daily<cr>", desc = "📅 Daily Challenge" }, 
    { "<leader>lr", "<cmd>Leet random<cr>", desc = "🎲 Random Problem" },
    
    -- Smart filtering (demo feature)
    { "<leader>le", "<cmd>Leet list difficulty=easy<cr>", desc = "🟢 Easy Problems" },
    { "<leader>lm", "<cmd>Leet list difficulty=medium<cr>", desc = "🟡 Medium Problems" },
    { "<leader>lh", "<cmd>Leet list difficulty=hard<cr>", desc = "🔴 Hard Problems" },
    { "<leader>lu", "<cmd>Leet list status=todo<cr>", desc = "📝 Unsolved Problems" },
    { "<leader>lS", "<cmd>Leet list status=solved<cr>", desc = "✅ Solved Problems" },
    
    -- === DEVELOPMENT WORKFLOW ===
    { "<leader>lt", "<cmd>Leet test<cr>", desc = "🧪 Test Solution" },
    { "<leader>lT", "<cmd>Leet run<cr>", desc = "▶️  Run Code" },
    { "<leader>ls", "<cmd>Leet submit<cr>", desc = "📤 Submit Solution" },
    
    -- === CODE MANAGEMENT ===
    { "<leader>ly", "<cmd>Leet yank<cr>", desc = "📋 Copy Solution" },
    { "<leader>lR", "<cmd>Leet reset<cr>", desc = "🔄 Reset Code" },
    { "<leader>lL", "<cmd>Leet last_submit<cr>", desc = "📜 Last Submission" },
    { "<leader>lI", "<cmd>Leet inject<cr>", desc = "💉 Re-inject Template" },
    
    -- === SESSION MANAGEMENT ===
    { "<leader>lb", "<cmd>Leet tabs<cr>", desc = "📑 Problem Tabs" },
    { "<leader>li", "<cmd>Leet info<cr>", desc = "ℹ️  Problem Details" },
    { "<leader>lc", "<cmd>Leet console<cr>", desc = "💻 Toggle Console" },
    { "<leader>lo", "<cmd>Leet open<cr>", desc = "🌐 Open in Browser" },
    
    -- === UTILITIES ===
    { "<leader>lC", "<cmd>Leet cache update<cr>", desc = "♻️  Refresh Cache" },
    { "<leader>lL", "<cmd>Leet lang<cr>", desc = "🔤 Change Language" },
    { "<leader>lD", "<cmd>Leet desc toggle<cr>", desc = "👁️  Toggle Description" },
    { "<leader>lSt", "<cmd>Leet desc stats<cr>", desc = "📊 Toggle Stats" },
    
    -- === HELP SYSTEM ===
    { "<leader>l?", function()
      vim.notify([[
🎮 LeetCode Pro Keybinds Reference
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 QUICK START:
   <leader>lq     Launch LeetCode
   <leader>ll     Browse all problems
   <leader>ld     Today's challenge
   <leader>lr     Random problem

📊 SMART FILTERS:
   <leader>le     Easy problems only
   <leader>lm     Medium problems  
   <leader>lh     Hard problems
   <leader>lu     Unsolved problems
   <leader>lS     Solved problems

⚡ DEVELOPMENT:
   <leader>lt     Test your solution
   <leader>ls     Submit solution
   <leader>lR     Reset code

🎯 SESSION:
   <leader>lb     Open problem tabs
   <leader>li     Problem details
   <leader>lc     Toggle console
   <leader>lo     Open in browser

🔧 UTILITIES:
   <leader>lC     Update problem cache
   <leader>lL     Change language
   <leader>lD     Toggle description
   
💡 In LeetCode interface:
   H/L           Focus testcases/results
   1,2,3...      Switch test cases
   q/<Esc>       Close panels
   <C-hjkl>      Navigate windows
      ]], vim.log.levels.INFO, { title = "🎮 LeetCode Pro Guide" })
    end, desc = "❓ Complete Help Guide" },
  },
}
