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

			},
			formatters = {
				djlint = {
					prepend_args = { "--reformat" },
				},
			},
		})
	end,
}
