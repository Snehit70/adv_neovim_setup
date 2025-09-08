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
				{ "<leader>bc", desc = "󰅖 close buffer" },
				{ "<leader>bo", desc = "󰰀 close others" },
				{ "<leader>bp", desc = "󰸟 pick buffer" },
				{ "<leader>br", desc = "󰰈 close right" },
				{ "<leader>bl", desc = "󰰆 close left" },

				-- Code
				{ "<leader>c", group = "󰘦 code" },
				{ "<leader>cf", desc = "󰉿 format code" },
				{ "<leader>ca", desc = "󰌶 code actions" },

				-- Diagnostics/LSP
				{ "<leader>d", desc = "󰱑 line diagnostics" },
				{ "<leader>q", desc = "󰙅 diagnostics list" },
				{ "<leader>rn", desc = "󰑕 rename symbol" },

				-- File/Find
				{ "<leader>f", group = "󰱼 find" },
				{ "<leader>ff", desc = "󰈞 find files" },
				{ "<leader>fg", desc = "󰛔 live grep" },
				{ "<leader>fb", desc = "󰸝 find buffers" },

				-- Git
				{ "<leader>g", group = "󰊢 git" },
				{ "<leader>gS", desc = "󰈖 stage buffer" },
				{ "<leader>gR", desc = "󰦛 reset buffer" },

				-- Explorer
				{ "<leader>e", desc = "󰙅 file explorer" },

				-- Terminal
				{ "<leader>t", group = "󰙅 terminal" },
				{ "<leader>tt", desc = "󰻃 toggle terminal" },
				{ "<leader>th", desc = "󰦘 terminal horizontal" },

				-- Help
				{ "<leader>?", desc = "󰘥 which-key help" },
			},
			{
				mode = { "n" },
				-- Navigation
				{ "[", group = "󰒮 prev" },
				{ "]", group = "󰒭 next" },

				-- Goto
				{ "g", group = "󰞉 goto" },
				{ "gc", group = "󰅈 comment line" },
				{ "gb", group = "󰅈 comment block" },
				{ "gco", desc = "󰅈 comment above" },
				{ "gcO", desc = "󰅈 comment below" },
				{ "gcA", desc = "󰅈 comment end" },

				-- Other useful mappings
				{ "K", desc = "󰘥 hover docs" },
				{ "<Tab>", desc = "󰓩 next buffer" },
			},
			{
				mode = { "v" },
				-- Visual mode specific
				{ "gc", desc = "󰅈 toggle comment" },
				{ "gb", desc = "󰅈 toggle block comment" },
			},
			{
				mode = { "x" },
				-- Select mode
			},
		},
		preset = "modern",
		delay = 100, -- Faster response
		expand = 2, -- Show more mappings before grouping
		notify = true,
		sort = { "local", "order", "group", "alphanum", "mod" },

		-- Enhanced styling
		win = {
			border = "rounded",
			padding = { 1, 2 },
			title = true,
			title_pos = "center",
			zindex = 1000,
		},

		layout = {
			width = { min = 20, max = 50 },
			spacing = 3,
			align = "left",
		},

		show_help = true,
		show_keys = true,
		disable = {
			buftypes = {},
			filetypes = {},
		},

		triggers = {
			{ "<auto>", mode = "nxsotc" },
			{ "<leader>", mode = { "n", "v" } },
			{ "g", mode = { "n", "v" } },
			{ "s", mode = { "n" } },
			{ "[", mode = { "n" } },
			{ "]", mode = { "n" } },
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
