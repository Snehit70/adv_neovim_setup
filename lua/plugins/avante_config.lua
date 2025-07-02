-- ~/.config/nvim/lua/plugins/avante.lua
return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		-- Provider configuration - you can switch between providers
		provider = "copilot", -- Since you already have copilot setup
		-- Alternative providers you can switch to:
		-- provider = "claude", -- Recommended for best results
		-- provider = "openai",

		-- Copilot configuration (since you're using copilot)
		providers = {
			copilot = {
			--	endpoint = "https://api.githubcopilot.com",
				model = "gpt-4o-2024-05-13",
				proxy = nil,
				allow_insecure = false,
				timeout = 30000,
				extra_request_body = {
					temperature = 0,
					max_tokens = 4096,
				},
			},
		},
		-- Advanced behavior settings
		behaviour = {
			auto_suggestions = false, -- Keep false since you have copilot.lua
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
			minimize_diff = true,
			enable_token_counting = true,
		},

		-- Custom mappings - fully customizable
		mappings = {
			diff = {
				ours = "co",
				theirs = "ct",
				all_theirs = "ca",
				both = "cb",
				cursor = "cc",
				next = "]x",
				prev = "[x",
			},
			suggestion = {
				accept = "<M-l>",
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
			jump = {
				next = "]]",
				prev = "[[",
			},
			submit = {
				normal = "<CR>",
				insert = "<C-s>",
			},
			sidebar = {
				apply_all = "A",
				apply_cursor = "a",
				retry_user_request = "r",
				edit_user_request = "e",
				switch_windows = "<Tab>",
				reverse_switch_windows = "<S-Tab>",
				remove_file = "d",
				add_file = "@",
				close = { "<Esc>", "q" },
			},
		},

		-- Window configuration
		windows = {
			position = "right", -- "right" | "left" | "top" | "bottom"
			wrap = true,
			width = 35, -- % based on available width
			sidebar_header = {
				enabled = true,
				align = "center", -- "left" | "center" | "right"
				rounded = true,
			},
      spinner= {
        editing={ "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"},
      },
			input = {
				prefix = "> ",
				height = 8,
			},
			edit = {
				border = "rounded",
				start_insert = true,
			},
			ask = {
				floating = false,
				start_insert = true,
				border = "rounded",
				focus_on_apply = "ours", -- "ours" | "theirs"
			},
		},

		-- Advanced features
		hints = { enabled = true },

		-- Diff configuration
		diff = {
			autojump = true,
			list_opener = "copen", -- or function() vim.cmd("Trouble quickfix") end
			override_timeoutlen = 500,
		},

		-- Suggestion timing (adjust for performance)
		suggestion = {
			debounce = 300,
			throttle = 300,
		},

		-- File selector provider
		selector = {
			provider = "telescope", -- "native" | "fzf_lua" | "mini_pick" | "telescope"
      provider_opts = {
        telescope = {
          layout_strategy = "vertical",
          layout_config = {
            height = 0.8,
            width = 0.8,
            preview_cutoff = 1,
            preview_height = 0.4,
          },
        },
      },
		},

		-- Web search integration (optional)
		web_search_engine = {
			provider = "tavily", -- requires TAVILY_API_KEY env var
			proxy = nil,
		},

		-- Custom tools (optional - advanced feature)
		custom_tools = {
			{
				name = "run_tests",
				description = "Run project tests",
				command = "npm test", -- or whatever test command you use
				param = {
					type = "table",
					fields = {
						{
							name = "pattern",
							description = "Test pattern to run",
							type = "string",
							optional = true,
						},
					},
				},
				func = function(params, on_log, on_complete)
					local pattern = params.pattern or ""
					return vim.fn.system("npm test " .. pattern)
				end,
			},
		},
	},

	-- Build configuration for Fedora Linux
	build = "make",

	-- Dependencies
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",

		-- Optional dependencies (you probably have these)
		"nvim-telescope/telescope.nvim", -- for file selector
		"hrsh7th/nvim-cmp", -- for autocompletion
		"nvim-tree/nvim-web-devicons", -- or "echasnovski/mini.icons"

		-- Your existing copilot setup
		"zbirenbaum/copilot.lua", -- You already have this

		-- Image support (optional)
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					use_absolute_path = true, -- Important for Linux
				},
			},
		},

		-- Markdown rendering
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},

	-- Lazy loading configuration
	cmd = {
		"AvanteAsk",
		"AvanteChat",
		"AvanteToggle",
		"AvanteBuild",
		"AvanteEdit",
		"AvanteRefresh",
	},

	-- Key bindings (customize as needed)
	keys = {
		{
			"<leader>aa",
			function()
				require("avante.api").ask()
			end,
			desc = "avante: ask",
		},
		{
			"<leader>ar",
			function()
				require("avante.api").refresh()
			end,
			desc = "avante: refresh",
		},
		{
			"<leader>ae",
			function()
				require("avante.api").edit()
			end,
			mode = "v",
			desc = "avante: edit",
		},
		{
			"<leader>at",
			function()
				require("avante").toggle()
			end,
			desc = "avante: toggle",
		},
		{
			"<leader>af",
			function()
				require("avante").focus()
			end,
			desc = "avante: focus",
		},
		{
			"<leader>ac",
			function()
				require("avante").chat()
			end,
			desc = "avante: chat",
		},
	},
}
