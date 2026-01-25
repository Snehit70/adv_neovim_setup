-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- Import plugins from lua/plugins/
		{ import = "plugins" },
	},
	defaults = {
		lazy = true, -- plugins are lazy-loaded by default for faster startup
		version = "*", -- use latest stable release( semver )
	},
	checker = {
		enabled = true,
		notify = false, -- Check for updates in background but don't notify
	}, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- Disable unused built-in plugins for faster startup
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen", -- Disabled: rainbow-delimiters provides bracket highlighting via treesitter
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"man",
				"rplugin",
				"health",
				"spellfile_plugin",
			},
		},
	},
})
