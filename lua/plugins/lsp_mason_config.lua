-- lua/plugins/lspconfig.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(client, bufnr)
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
			end

			map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
			map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
			map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
			map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
			map("n", "gr", vim.lsp.buf.references, "Find References")

			map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
			map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
			map("n", "<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")
			map("n", "<leader>q", vim.diagnostic.setloclist, "Open Diagnostics List")

			if client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = bufnr,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
			underline = true,
			virtual_text = true,
			update_in_insert = false,
			severity_sort = true,
		})

		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						diagnostics = {
							globals = { "vim", "use", "describe", "it", "assert", "stub" }, -- Added more globals
							disable = { "missing-fields" }, -- Stops some annoying warnings
						},
						workspace = {
							library = {
								vim.env.VIMRUNTIME,
								"${3rd}/luv/library",
								"${3rd}/busted/library",
							},
							checkThirdParty = false,
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
						telemetry = { enable = false },
						format = {
							enable = true,
						},
						hint = {
							enable = true, -- Shows inline type hints
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
						completion = {
							callSnippet = "Replace",
							keywordSnippet = "Replace",
						},
					},
				},
			},
			pyright = {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							diagnosticSeverityOverrides = {
								reportGeneralTypeIssues = "warning",
								reportOptionalMemberAccess = "none",
								reportOptionalSubscript = "none",
								reportUnknownMemberType = "none",
								reportAttributeAccessIssue = "none",
							},
						},
					},
				},
				before_init = function(_, config)
					local venv_path = os.getenv("VIRTUAL_ENV")
					if venv_path then
						config.settings.python.pythonPath = venv_path .. "/bin/python"
					end
				end,
				root_dir = lspconfig.util.root_pattern("app.py", "models.py", "requirements.txt", ".git"),
			},
			ts_ls = {},
			html = {
				settings = {
					html = {
						format = {
							enable = true,
							wrapLineLength = 120,
							indentHandlebars = true, -- Helps with Jinja2 too
							templating = true, -- Won't break on {{ }} syntax
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
						-- Bootstrap + Tailwind class suggestions
						customData = {},
					},
				},
				filetypes = { "html", "htm", "htmldjango" }, -- htmldjango for better Jinja2 support
				init_options = {
					configurationSection = { "html", "css", "javascript" },
					embeddedLanguages = {
						css = true,
						javascript = true,
					},
					provideFormatter = true,
				},
			},
			emmet_ls = {
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
			jinja_lsp = {
				filetypes = { "html", "htmldjango", "jinja", "jinja2" },
				root_dir = lspconfig.util.root_pattern("app.py", "templates/", ".git"),
			},
			cssls = {
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
