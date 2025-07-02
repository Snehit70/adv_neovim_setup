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
				layout_strategy = "horizontal",
				layout_config = {
					preview_cutoff = 120,
					horizontal = { width = 0.9, preview_width = 0.6 },
				},
				sorting_strategy = "ascending",
				winblend = 0,
			},
			pickers = {
				find_files = {
					hidden = false,
				},
			},
		})

		-- Keymaps
		local keymap = vim.keymap.set
		--		local opts = { noremap = true, silent = true }

		keymap("n", "<leader>ff", builtin.find_files, { noremap = true, silent = true, desc = "files" })
		keymap("n", "<leader>fg", builtin.live_grep, { noremap = true, silent = true, desc = "grep" })
		keymap("n", "<leader>fb", builtin.buffers, { noremap = true, silent = true, desc = "find buffers" })
		keymap("n", "<leader>fh", builtin.help_tags, { noremap = true, silent = true, desc = "help" })

		-- LSP-specific Telescope pickers (only if LSP is active)
		--    keymap("n", "<leader>fd", builtin.lsp_definitions, opts)
		--    keymap("n", "<leader>fr", builtin.lsp_references, opts)
		--    keymap("n", "<leader>fi", builtin.lsp_implementations, opts)
		--    keymap("n", "<leader>fs", builtin.lsp_document_symbols, opts)
	end,
}
