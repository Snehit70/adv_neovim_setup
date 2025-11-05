-- ~/.config/nvim/lua/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{
				mode = { "n", "v" },
				-- Buffer Management
				{ "<leader>b", group = "󰓩 buffers" },
				{ "<leader>bc", desc = "Close Buffer" },
				{ "<leader>bo", desc = "Close Others" },
				{ "<leader>bp", desc = "Pick Buffer" },
				{ "<leader>br", desc = "Close Right" },
				{ "<leader>bl", desc = "Close Left" },
				{ "<leader>be", desc = "Buffer Explorer" },

				-- Code
				{ "<leader>c", group = " code" },
				{ "<leader>cf", desc = "Format Code" },
				{ "<leader>ca", desc = "Code Actions" },
				{ "<leader>cl", desc = "Run CodeLens" },
				{ "<leader>cu", desc = "Update Cache" },

				-- Diagnostics/LSP
				{ "<leader>d", desc = " Line Diagnostics" },
				{ "<leader>q", desc = " Diagnostics List" },
				{ "<leader>rn", desc = " Rename Symbol" },

				-- File/Find (Telescope)
				{ "<leader>f", group = " telescope" },
				{ "<leader>ff", desc = "Find Files" },
				{ "<leader>fg", desc = "Live Grep" },
				{ "<leader>fb", desc = "Find Buffers" },
				{ "<leader>fh", desc = "Help Tags" },
				{ "<leader>fo", desc = "Old Files" },
				{ "<leader>fc", desc = "Find Commands" },
				{ "<leader>fk", desc = "Find Keymaps" },
				{ "<leader>fs", desc = "Grep String" },
				{ "<leader>fr", desc = "Resume Last" },
				{ "<leader>fm", desc = "Find Man Pages" },

				-- Git (Gitsigns + Telescope)
				{ "<leader>g", group = " git" },
				{ "<leader>gb", desc = " Full Blame" },
				{ "<leader>gbl", desc = " Blame Line" },
				{ "<leader>gbc", desc = " Buffer Commits" },
				{ "<leader>gS", desc = " Stage Buffer" },
				{ "<leader>gR", desc = " Reset Buffer" },
				{ "<leader>gd", desc = " Diff This" },
				{ "<leader>gdt", desc = " Diff This ~" },
				{ "<leader>gD", desc = " Diff Float" },
				{ "<leader>gt", desc = " Toggle Blame" },
				{ "<leader>gts", desc = " Toggle Signs" },
				{ "<leader>gtd", desc = " Toggle Deleted" },
				{ "<leader>gf", desc = " Git Status" },
				{ "<leader>gc", desc = " Git Commits" },

				-- Explorer
				{ "<leader>e", desc = " File Explorer" },
				{ "<leader>E", desc = " Focus Explorer" },
				{ "<leader>ge", desc = " Git Status Explorer" },
				{ "<leader>se", desc = " Symbols Explorer" },

				-- LeetCode
				{ "<leader>l", group = " leetcode" },
				{ "<leader>lq", desc = "LeetCode Menu" },
				{ "<leader>ll", group = " list" },
				{ "<leader>lll", desc = "List Problems" },
				{ "<leader>lle", desc = "Easy Problems" },
				{ "<leader>llm", desc = "Medium Problems" },
				{ "<leader>llh", desc = "Hard Problems" },
				{ "<leader>llg", desc = "Change Language" },
				{ "<leader>llst", desc = "Last Submission" },
				{ "<leader>lt", desc = " Test Solution" },
				{ "<leader>ltb", desc = "Open Tabs" },
				{ "<leader>ls", desc = " Submit Solution" },
				{ "<leader>lr", desc = " Run Solution" },
				{ "<leader>lrn", desc = "Random Problem" },
				{ "<leader>lrs", desc = "Restore Layout" },
				{ "<leader>lrst", desc = "Reset Code" },
				{ "<leader>li", desc = " Info" },
				{ "<leader>linj", desc = "Re-inject Code" },
				{ "<leader>lc", group = " console/cache" },
				{ "<leader>lcc", desc = "Open Console" },
				{ "<leader>lcu", desc = "Update Cache" },
				{ "<leader>ld", group = " description/daily" },
				{ "<leader>ldd", desc = "Toggle Description" },
				{ "<leader>ldt", desc = "Toggle Stats" },
				{ "<leader>ldy", desc = "Daily Problem" },
				{ "<leader>ly", desc = " Yank Code" },
				{ "<leader>lo", desc = " Open in Browser" },
				{ "<leader>lx", desc = " Exit LeetCode" },

				-- Markdown
				{ "<leader>m", group = " markdown" },
				{ "<leader>mp", desc = "Toggle Preview" },
				{ "<leader>mo", desc = "Open Preview" },
				{ "<leader>mc", desc = "Close Preview" },

				-- Search/Session
				{ "<leader>s", group = " search/session" },
				{ "<leader>ss", desc = "Save Session" },
				{ "<leader>sr", desc = "Restore Session" },
				{ "<leader>sd", desc = "Delete Session" },
				{ "<leader>sf", desc = "Search Files" },
				{ "<leader>sg", desc = "Search Grep" },

				-- Terminal/Toggle
				{ "<leader>t", group = " terminal/toggle" },
				{ "<leader>tt", desc = "Toggle Terminal" },
				{ "<leader>th", desc = "Terminal Horizontal" },
				{ "<leader>tv", desc = "Terminal Vertical" },
				{ "<leader>tf", desc = "Terminal Float" },

				-- Window Operations
				{ "<leader>w", group = " windows" },
				{ "<leader>ww", desc = "Other Window" },
				{ "<leader>wd", desc = "Delete Window" },
				{ "<leader>ws", desc = "Split Below" },
				{ "<leader>wv", desc = "Split Right" },
				{ "<leader>wh", desc = "Focus Left" },
				{ "<leader>wj", desc = "Focus Down" },
				{ "<leader>wk", desc = "Focus Up" },
				{ "<leader>wl", desc = "Focus Right" },
				{ "<leader>w=", desc = "Equal Size" },
				{ "<leader>w|", desc = "Max Width" },
				{ "<leader>w_", desc = "Max Height" },

				-- Trouble/Diagnostics
				{ "<leader>x", group = " trouble" },
				{ "<leader>xx", desc = "Toggle Trouble" },
				{ "<leader>xw", desc = "Workspace Diagnostics" },
				{ "<leader>xd", desc = "Document Diagnostics" },
				{ "<leader>xq", desc = "Quickfix" },
				{ "<leader>xl", desc = "Location List" },
				{ "<leader>xr", desc = "LSP References" },

				-- Help
				{ "<leader>?", desc = " Which-key Help" },
				{ "<leader>/", desc = " Comment Toggle" },
			},
			{
				mode = { "n" },
				-- Navigation
				{ "[", group = " prev" },
				{ "[b", desc = "Previous Buffer" },
				{ "[d", desc = "Previous Diagnostic" },
				{ "[g", desc = "Previous Git Hunk" },
				{ "[q", desc = "Previous Quickfix" },
				{ "[t", desc = "Previous Todo" },
				
				{ "]", group = " next" },
				{ "]b", desc = "Next Buffer" },
				{ "]d", desc = "Next Diagnostic" },
				{ "]g", desc = "Next Git Hunk" },
				{ "]q", desc = "Next Quickfix" },
				{ "]t", desc = "Next Todo" },

				-- Goto (LSP)
				{ "g", group = " goto" },
				{ "gd", desc = "Go to Definition" },
				{ "gD", desc = "Go to Declaration" },
				{ "gr", desc = "Go to References" },
				{ "gi", desc = "Go to Implementation" },
				{ "gt", desc = "Go to Type Definition" },
				
				-- Comment
				{ "gc", group = " comment line" },
				{ "gb", group = " comment block" },
				{ "gco", desc = "Comment Above" },
				{ "gcO", desc = "Comment Below" },
				{ "gcA", desc = "Comment End" },

				-- Other useful mappings
				{ "K", desc = " Hover Docs" },
				{ "<C-k>", desc = " Signature Help" },
				{ "<Tab>", desc = " Next Buffer" },
				{ "<S-Tab>", desc = " Previous Buffer" },
				
				-- LSP
				{ "gl", desc = " Line Diagnostics" },
				
				-- Marks
				{ "m", group = " marks" },
				{ "'", group = " jump to mark" },
				{ "`", group = " jump to mark (exact)" },
				
				-- Registers
				{ '"', group = " registers" },
				
				-- Window commands
				{ "<C-w>", group = " windows" },
				{ "<C-w>s", desc = "Split Below" },
				{ "<C-w>v", desc = "Split Right" },
				{ "<C-w>c", desc = "Close Window" },
				{ "<C-w>o", desc = "Close Others" },
				{ "<C-w>h", desc = "Focus Left" },
				{ "<C-w>j", desc = "Focus Down" },
				{ "<C-w>k", desc = "Focus Up" },
				{ "<C-w>l", desc = "Focus Right" },
				{ "<C-w>w", desc = "Other Window" },
				{ "<C-w>=", desc = "Equal Size" },
				{ "<C-w>|", desc = "Max Width" },
				{ "<C-w>_", desc = "Max Height" },
				{ "<C-w>+", desc = "Increase Height" },
				{ "<C-w>-", desc = "Decrease Height" },
				{ "<C-w>>", desc = "Increase Width" },
				{ "<C-w><", desc = "Decrease Width" },
				
				-- z-commands (folding, scrolling)
				{ "z", group = " fold/scroll" },
				{ "za", desc = "Toggle Fold" },
				{ "zA", desc = "Toggle Fold Recursive" },
				{ "zc", desc = "Close Fold" },
				{ "zC", desc = "Close Fold Recursive" },
				{ "zo", desc = "Open Fold" },
				{ "zO", desc = "Open Fold Recursive" },
				{ "zM", desc = "Close All Folds" },
				{ "zR", desc = "Open All Folds" },
				{ "zz", desc = "Center Cursor" },
				{ "zt", desc = "Top Cursor" },
				{ "zb", desc = "Bottom Cursor" },
			},
			{
				mode = { "v" },
				-- Visual mode specific
				{ "gc", desc = " Toggle Comment" },
				{ "gb", desc = " Toggle Block Comment" },
				{ "<leader>/", desc = " Comment Selection" },
				{ "<", desc = " Decrease Indent" },
				{ ">", desc = " Increase Indent" },
				{ "J", desc = " Move Line Down" },
				{ "K", desc = " Move Line Up" },
				{ "p", desc = " Paste (keep register)" },
			},
			{
				mode = { "x" },
				-- Select mode
				{ "<leader>", group = "󰘳 leader" },
			},
			{
				mode = { "i" },
				-- Insert mode completions
				{ "<C-x>", group = " completion" },
				{ "<C-x><C-f>", desc = "File Path" },
				{ "<C-x><C-l>", desc = "Whole Line" },
				{ "<C-x><C-o>", desc = "Omni Completion" },
				{ "<C-x><C-n>", desc = "Keywords (forward)" },
				{ "<C-x><C-p>", desc = "Keywords (backward)" },
			},
			{
				mode = { "o" },
				-- Operator-pending mode
				{ "i", group = " inside" },
				{ "a", group = " around" },
			},
		},
		preset = "modern",
		delay = 200, -- Balanced response time
		expand = 1, -- Automatic grouping
		notify = true,
		sort = { "local", "order", "group", "alphanum", "mod" },

		-- Enhanced styling with icons
		icons = {
			breadcrumb = "»", -- symbol used in command line area
			separator = "➜", -- symbol used between a key and it's label
			group = "+", -- symbol prepended to a group
			ellipsis = "…",
			-- Custom icons for specific mappings
			mappings = true,
			rules = false,
			colors = true,
			keys = {
				Up = " ",
				Down = " ",
				Left = " ",
				Right = " ",
				C = "󰘴 ",
				M = "󰘵 ",
				D = "󰘳 ",
				S = "󰘶 ",
				CR = "󰌑 ",
				Esc = "󱊷 ",
				ScrollWheelDown = "󱕐 ",
				ScrollWheelUp = "󱕑 ",
				NL = "󰌑 ",
				BS = "󰁮",
				Space = "󱁐 ",
				Tab = "󰌒 ",
				F1 = "󱊫",
				F2 = "󱊬",
				F3 = "󱊭",
				F4 = "󱊮",
				F5 = "󱊯",
				F6 = "󱊰",
				F7 = "󱊱",
				F8 = "󱊲",
				F9 = "󱊳",
				F10 = "󱊴",
				F11 = "󱊵",
				F12 = "󱊶",
			},
		},

		-- Enhanced window styling
		win = {
			border = "rounded",
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
			zindex = 1000,
			wo = {
				winblend = 0, -- Transparency (0-100)
			},
		},

		layout = {
			width = { min = 20, max = 50 },
			height = { min = 4, max = 25 },
			spacing = 3,
			align = "left",
		},

		show_help = true,
		show_keys = true,
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},

		-- Optimized triggers
		triggers = {
			{ "<auto>", mode = "nxso" },
			{ "<leader>", mode = { "n", "v" } },
			{ "g", mode = { "n", "v" } },
			{ "z", mode = { "n" } },
			{ "[", mode = { "n" } },
			{ "]", mode = { "n" } },
			{ "<C-w>", mode = { "n" } },
			{ '"', mode = { "n", "v" } },
			{ "'", mode = { "n", "v" } },
			{ "`", mode = { "n", "v" } },
		},
	},

	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "󰘥 Buffer Local Keymaps (which-key)",
		},
		{
			"<c-w><space>",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},
	},
}
