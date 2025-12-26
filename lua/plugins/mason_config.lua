-- lua/plugins/mason.lua
return {
	"williamboman/mason.nvim",
	cmd = "Mason", -- Lazy load: only loads when you run :Mason
	build = ":MasonUpdate",
	opts = {
		PATH = "prepend", -- Ensure Mason-installed binaries are found
		ui = {
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
}
