return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		
		vim.diagnostic.config({
			signs = { -- Icons to display in the sign column for diagnostics.
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
			underline = true,
			virtual_text = false,
			update_in_insert = false,
			severity_sort = true,
		})

		local servers = {
			lua_ls = {},
			pyright = {},
			ts_ls = {},
			html = {
				settings = {
					html = {
						format = {
							enable = true,
							wrapLineLength = 120,
							indentHandlebars = true, -- Helps with Jinja2 formatting.
							templating = true, -- Prevents breaking on templating syntax like {{ }}.
							wrapAttributes = "auto",
						},
						hover = {
							documentation = true,
							references = true,
						},
						completion = {
							attributeDefaultValue = "doublequotes",
						},
						validate = {
							styles = true,
							scripts = true,
						},
						suggest = {
							html5 = true,
							angular1 = false,
							ionic = false,
						},
						
					},
				},
				filetypes = { "html", "htm", "htmldjango", "jinja", "jinja2" },
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true,
					},
					provideFormatter = true,
				},
			},
			emmet_ls = { -- Configuration for the Emmet Language Server.
				filetypes = { "html", "htmldjango", "css", "scss", "javascript", "javascriptreact", "typescriptreact" },
				init_options = {
					html = {
						options = {
							["bem.enabled"] = true,
							["output.selfClosingStyle"] = "html",
						},
					},
					css = {
						options = {
							["css.color.short"] = true,
						},
					},
				},
			},
			jinja_lsp = { -- Configuration for the Jinja Language Server.
				filetypes = { "html", "htmldjango", "jinja", "jinja2" },
				root_dir = lspconfig.util.root_pattern("app.py", "run.py", "templates", "static", "src", ".git", "pyproject.toml", "setup.py"),
			},
			cssls = { -- Configuration for the CSS Language Server.
				settings = {
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore", -- Won't complain about @tailwind directives
							duplicateProperties = "warning",
							emptyRulesets = "warning",
							importStatement = "ignore", -- For @import statements
						},
						completion = {
							triggerPropertyValueCompletion = true,
							completePropertyWithSemicolon = true,
						},
						hover = {
							documentation = true,
							references = true,
						},
						format = {
							enable = true,
							preserveNewLines = true,
						},
						customData = {}, -- For future Bootstrap/Tailwind class definitions
					},
					scss = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
							duplicateProperties = "warning",
						},
						completion = {
							triggerPropertyValueCompletion = true,
							completePropertyWithSemicolon = true,
						},
					},
					less = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
				filetypes = { "css", "scss", "less", "html", "htmldjango" }, -- Works in HTML too
				init_options = {
					provideFormatter = true,
				},
				root_dir = lspconfig.util.root_pattern("static/", "assets/", "css/", "package.json", ".git"),
			},
			bashls = {},
			jsonls = {},
		}

		for server, opts in pairs(servers) do
			opts.on_attach = on_attach
			opts.capabilities = capabilities
			lspconfig[server].setup(opts)
		end
	end,
}
