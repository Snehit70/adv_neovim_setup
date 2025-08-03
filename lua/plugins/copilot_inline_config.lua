return {
	{
		"zbirenbaum/copilot.lua",
		-- Defines a Neovim command ':Copilot' to manually load and interact with the plugin.
		-- This allows for on-demand loading, reducing Neovim startup time if not needed immediately.
		cmd = "Copilot",
		-- Lazy-loads the plugin automatically when entering insert mode.
		-- Copilot is primarily useful when typing, so this ensures it's ready when needed
		-- without slowing down initial launch.
		event = "InsertEnter",
		-- Configuration function for the copilot.lua plugin.
		config = function()
			-- Keymap to toggle Copilot globally.
			-- <leader>co will enable/disable Copilot suggestions across all buffers.
			vim.keymap.set("n", "<leader>co", function() require("copilot").toggle() end, { desc = "Toggle Copilot" })
			-- Keymap to explicitly trigger a Copilot suggestion.
			-- Since auto_trigger is false, this allows manual prompting for suggestions,
			-- which will then appear in the nvim-cmp completion menu.
			vim.keymap.set("i", "<leader>cs", function() require("copilot.suggestion").trigger() end, { desc = "Trigger Copilot suggestion" })
			-- Keymap to dismiss/clear the current Copilot suggestion.
			-- Useful for rejecting unwanted suggestions without accepting or cycling.
			vim.keymap.set("i", "<leader>cd", function() require("copilot.suggestion").dismiss() end, { desc = "Dismiss Copilot suggestion" })

			-- Main setup for the copilot.lua plugin.
			require("copilot").setup({
				-- Configuration for the Copilot suggestions panel.
				panel = {
					-- Activates the Copilot suggestions panel, allowing multiple suggestions to be viewed.
					enabled = true,
					-- Prevents the panel from automatically refreshing as you type, reducing distraction.
					-- Manual refresh (gr) is available.
					auto_refresh = false,
					-- Keybindings for navigating and interacting with the Copilot panel.
					keymap = {
						jump_prev = "[[", -- Move to the previous suggestion in the panel.
						jump_next = "]]", -- Move to the next suggestion in the panel.
						accept = "<CR>", -- Accept the currently highlighted suggestion in the panel.
						refresh = "gr", -- Manually refresh suggestions in the panel.
						open = "<M-CR>", -- (Alt + Enter) Open the Copilot panel.
					},
					-- Layout settings for the Copilot panel.
					layout = {
						position = "bottom", -- Places the panel at the bottom of the Neovim window.
						ratio = 0.4, -- The panel will take up 40% of the available height.
					},
				},
				-- Configuration for inline "ghost text" suggestions.
				suggestion = {
					-- Disables inline ghost text suggestions.
					-- This aligns with a preference for using the panel or nvim-cmp for suggestions,
					-- reducing visual clutter in the buffer.
					enabled = false, -- disable ghost text since you don't want it
					-- Prevents ghost text suggestions from automatically appearing.
					-- Redundant when 'enabled' is false, but reinforces the preference.
					auto_trigger = false,
					-- Filters Copilot suggestions to prioritize or only show those that match
					-- the current indentation level of your code. This improves relevance and
					-- helps maintain consistent code formatting.
					filter_by_indentation = true,
					-- Prevents copilot.lua from creating its own <Tab> mapping.
					-- This is crucial to avoid conflicts with nvim-cmp, ensuring <Tab>
					-- behaves consistently for completion navigation/acceptance.
					no_tab_map = true,
				},
				-- Specifies file types for which Copilot should be disabled.
				-- Suggestions are often less relevant or counterproductive in these contexts.
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					[".-"] = false, -- Disables Copilot for files with no file extension.
				},
				-- Specifies the command used to run the Node.js executable for Copilot.
				-- Assumes 'node' is in your system's PATH. Node.js version must be > 18.x.
				copilot_node_command = "node",
				-- Allows overriding options for the underlying Copilot language server.
				-- Currently empty, meaning no specific overrides are applied.
				server_opts_overrides = {},
			})
		end,
	},
	-- Configuration for the copilot-cmp plugin, which integrates Copilot with nvim-cmp.
	{
		"zbirenbaum/copilot-cmp",
		-- Declares that copilot-cmp depends on copilot.lua, ensuring it's loaded first.
		dependencies = { "zbirenbaum/copilot.lua" },
		-- Configuration function for copilot-cmp.
		config = function()
			require("copilot_cmp").setup({
				-- Specifies the method used to fetch suggestions from copilot.lua.
				-- 'getCompletionsCycling' implies it will cycle through available suggestions
				-- within the nvim-cmp completion menu.
				method = "getCompletionsCycling",
				-- Functions to format how Copilot suggestions appear in the nvim-cmp menu.
				formatters = {
					-- Formats the main text of the Copilot suggestion in the completion list.
					label = require("copilot_cmp.format").format_label_text,
					-- Formats the exact text that gets inserted into the buffer when a suggestion is accepted.
					insert_text = require("copilot_cmp.format").format_insert_text,
					-- De-indents the preview of the Copilot suggestion, making it easier to read
					-- in the floating preview window.
					preview = require("copilot_cmp.format").deindent,
				},
			})
		end,
	},
}