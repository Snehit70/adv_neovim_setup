return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufReadPre" }, -- Load before writing or reading files
	cmd = "ConformInfo",
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			desc = "Format current buffer",
		},
	},
	config = function()
		require("conform").setup({
			--[[ format_on_save = function(bufnr) ]]
			--[[ 	-- Enable format on save for allowed filetypes only ]]
			--[[ 	local ignore = { "markdown", "json", "txt" } -- Add here if needed ]]
			--[[ 	local ft = vim.bo[bufnr].filetype ]]
			--[[ 	if vim.tbl_contains(ignore, ft) then ]]
			--[[ 		return false ]]
			--[[ 	end ]]
			--[[ 	return { ]]
			--[[ 		timeout_ms = 500, ]]
			--[[ 		lsp_fallback = true, ]]
			--[[ 	} ]]
			--[[ end, ]]
			formatters_by_ft = {
				-- Explicit filetype-to-formatter mapping
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				lua = { "stylua" },
				sh = { "shfmt" },
				jinja = { "djlint" }, -- Optional, install separately
				htmldjango = { "djlint" }, -- Optional, install separately

				-- Add more as needed
				-- markdown = { "prettier" },  -- Optional, often better manual
				-- vue = { "prettier" },
				-- svelte = { "prettier" },
			},
			formatters = {
				djlint = {
					prepend_args = { "--reformat" },
				},
			},
		})
	end,
}
