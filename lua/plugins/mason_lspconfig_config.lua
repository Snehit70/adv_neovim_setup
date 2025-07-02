-- lua/plugins/mason-lspconfig.lua
return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	opts = {
		ensure_installed = {
			-- LSP servers (you already have these)
			"lua_ls",
			"pyright",
			"ts_ls",
			"html",
			"cssls",
			"bashls",
			"jsonls",
			"emmet_ls", -- ✓ You have this
			"jinja_lsp", -- ✓ You have this (use this instead of djlsp)
		},
		automatic_installation = false,
	},
}
