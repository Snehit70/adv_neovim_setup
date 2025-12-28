-- ~/.config/nvim/lua/plugins/which-key.lua
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		spec = {
			{
				mode = { "n", "v" },
				-- Buffer Management
				{ "<leader>b", group = "buffers" },
				{ "<leader>bc", desc = "Close Buffer" },
				{ "<leader>bo", desc = "Close Others" },

				-- Code
				{ "<leader>c", group = "code" },
				{ "<leader>cf", desc = "Format Code" },
				{ "<leader>ca", desc = "Code Actions" },

				-- Diagnostics/LSP
				{ "<leader>d", desc = "Line Diagnostics" },
				{ "<leader>q", desc = "Diagnostics List" },
				{ "<leader>rn", desc = "Rename Symbol" },

				-- File/Find (Telescope)
				{ "<leader>f", group = "telescope" },
				{ "<leader>ff", desc = "Find Files" },
				{ "<leader>fg", desc = "Live Grep" },
				{ "<leader>fb", desc = "Find Buffers" },
				{ "<leader>fh", desc = "Help Tags" },
				{ "<leader>fr", desc = "Recent Files" },
				{ "<leader>fc", desc = "Find Commands" },
				{ "<leader>fk", desc = "Find Keymaps" },
				{ "<leader>fn", desc = "New File" },

				-- Git (Gitsigns + Telescope)
				{ "<leader>g", group = "git" },
				{ "<leader>gb", desc = "Full Blame" },
				{ "<leader>gbl", desc = "Blame Line" },
				{ "<leader>gbc", desc = "Buffer Commits" },
				{ "<leader>gS", desc = "Stage Buffer" },
				{ "<leader>gR", desc = "Reset Buffer" },
				{ "<leader>gd", desc = "Diff This" },
				{ "<leader>gdt", desc = "Diff This ~" },
				{ "<leader>gD", desc = "Diff Float" },
				{ "<leader>gt", desc = "Toggle Blame" },
				{ "<leader>gts", desc = "Toggle Signs" },
				{ "<leader>gtd", desc = "Toggle Deleted" },
				{ "<leader>gf", desc = "Git Status" },
				{ "<leader>gc", desc = "Git Commits" },

				-- Explorer
				{ "<leader>e", desc = "File Explorer" },
				{ "<leader>E", desc = "Focus Explorer" },

				-- LeetCode
				{ "<leader>l", group = "leetcode" },
				{ "<leader>lq", desc = "LeetCode Menu" },
				{ "<leader>ll", desc = "List Problems" },
				{ "<leader>lle", desc = "Easy Problems" },
				{ "<leader>llm", desc = "Medium Problems" },
				{ "<leader>llh", desc = "Hard Problems" },
				{ "<leader>llg", desc = "Change Language" },
				{ "<leader>lt", desc = "Test Solution" },
				{ "<leader>ltb", desc = "Open Tabs" },
				{ "<leader>ls", desc = "Submit Solution" },
				{ "<leader>lr", desc = "Run Solution" },
				{ "<leader>lrn", desc = "Random Problem" },
				{ "<leader>lrs", desc = "Restore Layout" },
				{ "<leader>lrst", desc = "Reset Code" },
				{ "<leader>li", desc = "Info" },
				{ "<leader>linj", desc = "Re-inject Code" },
				{ "<leader>lc", desc = "Console" },
				{ "<leader>lcu", desc = "Update Cache" },
				{ "<leader>ld", desc = "Toggle Description" },
				{ "<leader>ldt", desc = "Toggle Stats" },
				{ "<leader>ldy", desc = "Daily Problem" },
				{ "<leader>ly", desc = "Yank Code" },
				{ "<leader>lo", desc = "Open in Browser" },
				{ "<leader>lx", desc = "Exit LeetCode" },
				{ "<leader>llst", desc = "Last Submission" },

				-- Markdown
				{ "<leader>m", group = "markdown" },
				{ "<leader>mp", desc = "Toggle Preview" },
				{ "<leader>mo", desc = "Open Preview" },
				{ "<leader>mc", desc = "Close Preview" },
				{ "<leader>mg", desc = "Glow Preview" },

				-- Terminal/Toggle
				{ "<leader>t", group = "terminal/toggle" },
				{ "<leader>tt", desc = "Toggle Terminal" },
				{ "<leader>th", desc = "Toggle Inlay Hints" },

				-- Swap (Treesitter)
				{ "<leader>a", desc = "Swap Param Next" },
				{ "<leader>A", desc = "Swap Param Prev" },

				-- Other
				{ "<leader>L", desc = "Lazy (Plugin Manager)" },
				{ "<leader>qq", desc = "Quit All" },
				{ "<leader>`", desc = "Switch to Alt Buffer" },
				{ "<leader>?", desc = "Which-key Help" },
			},
			{
				mode = { "n" },
				-- Navigation
				{ "[", group = "prev" },
				{ "[b", desc = "Previous Buffer" },
				{ "[d", desc = "Previous Diagnostic" },
				{ "[m", desc = "Previous Function" },
				{ "[a", desc = "Previous Parameter" },
				{ "[[", desc = "Previous Class" },

				{ "]", group = "next" },
				{ "]b", desc = "Next Buffer" },
				{ "]d", desc = "Next Diagnostic" },
				{ "]m", desc = "Next Function" },
				{ "]a", desc = "Next Parameter" },
				{ "]]", desc = "Next Class" },

				-- Goto (LSP)
				{ "g", group = "goto" },
				{ "gd", desc = "Go to Definition" },
				{ "gD", desc = "Go to Declaration" },
				{ "gr", desc = "Go to References" },
				{ "gi", desc = "Go to Implementation" },

				-- Flash
				{ "s", desc = "Flash Jump" },
				{ "S", desc = "Flash Treesitter" },

				-- Other useful mappings
				{ "K", desc = "Hover Docs" },
				{ "<C-k>", desc = "Signature Help" },
				{ "<Tab>", desc = "Next Buffer" },
				{ "<S-Tab>", desc = "Previous Buffer" },

				-- Marks
				{ "m", group = "marks" },
				{ "'", group = "jump to mark" },
				{ "`", group = "jump to mark (exact)" },

				-- Registers
				{ '"', group = "registers" },

				-- Window commands
				{ "<C-w>", group = "windows" },
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
				{ "z", group = "fold/scroll" },
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
				{ "<", desc = "Decrease Indent" },
				{ ">", desc = "Increase Indent" },
			},
			{
				mode = { "i" },
				-- Insert mode completions
				{ "<C-x>", group = "completion" },
				{ "<C-x><C-f>", desc = "File Path" },
				{ "<C-x><C-l>", desc = "Whole Line" },
				{ "<C-x><C-o>", desc = "Omni Completion" },
				{ "<C-x><C-n>", desc = "Keywords (forward)" },
				{ "<C-x><C-p>", desc = "Keywords (backward)" },
			},
			{
				mode = { "o" },
				-- Operator-pending mode
				{ "i", group = "inside" },
				{ "a", group = "around" },
				{ "r", desc = "Remote Flash" },
			},
			{
				mode = { "o", "x" },
				{ "R", desc = "Treesitter Search" },
			},
			{
				mode = { "c" },
				{ "<C-s>", desc = "Toggle Flash Search" },
			},
		},
		preset = "modern",
		delay = 200,
		expand = 1,
		notify = true,
		sort = { "local", "order", "group", "alphanum", "mod" },

		icons = {
			breadcrumb = ">>",
			separator = "->",
			group = "+",
			ellipsis = "...",
			mappings = true,
			rules = false,
			colors = true,
			keys = {
				Up = " ",
				Down = " ",
				Left = " ",
				Right = " ",
				C = "C-",
				M = "M-",
				D = "D-",
				S = "S-",
				CR = "CR ",
				Esc = "Esc ",
				ScrollWheelDown = "ScrollDown ",
				ScrollWheelUp = "ScrollUp ",
				NL = "NL ",
				BS = "BS ",
				Space = "Space ",
				Tab = "Tab ",
				F1 = "F1",
				F2 = "F2",
				F3 = "F3",
				F4 = "F4",
				F5 = "F5",
				F6 = "F6",
				F7 = "F7",
				F8 = "F8",
				F9 = "F9",
				F10 = "F10",
				F11 = "F11",
				F12 = "F12",
			},
		},

		win = {
			border = "rounded",
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
			zindex = 1000,
			wo = {
				winblend = 0,
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
			desc = "Buffer Local Keymaps (which-key)",
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
