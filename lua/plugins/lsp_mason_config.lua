return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp (completion plugin)
		"williamboman/mason-lspconfig.nvim", -- Bridges Mason and nvim-lspconfig
	},
	-- Configuration function for nvim-lspconfig.
	config = function()
		local lspconfig = require("lspconfig")

		-- Get default capabilities for LSP clients, enhanced by cmp-nvim-lsp.
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Function to be called when an LSP client attaches to a buffer.
		-- This sets up buffer-local keymaps for LSP features.
		local on_attach = function(client, bufnr)
			-- Helper function for creating buffer-local keymaps.
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
			end

			-- Keymaps for common LSP features:
			map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
			map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
			map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
			map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
			map("n", "gr", vim.lsp.buf.references, "Find References")

			-- Keymaps for diagnostics (errors, warnings, hints):
			map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
			map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
			map("n", "<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")
			map("n", "<leader>q", vim.diagnostic.setloclist, "Open Diagnostics List")

			-- Autocommands for document highlighting (e.g., highlighting references to a symbol).
			-- Only enabled if the LSP client supports document highlighting.
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

		-- Global diagnostic configuration for Neovim.
		vim.diagnostic.config({
			signs = { -- Icons to display in the sign column for diagnostics.
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
			underline = true, -- Underline diagnostics in the code.
			virtual_text = true, -- Display diagnostic messages as virtual text.
			update_in_insert = false, -- Do not update diagnostics in insert mode (reduces distraction).
			severity_sort = true, -- Sort diagnostics by severity.
		})

		-- Table defining configurations for various LSP servers.
		local servers = {
			lua_ls = { -- Configuration for the Lua Language Server.
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ";"),
						},
						diagnostics = {
							globals = { "vim", "use", "describe", "it", "assert", "stub" }, -- Custom global variables to avoid diagnostics.
							disable = { "missing-fields" }, -- Disables specific annoying warnings.
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
			pyright = { -- Configuration for the Pyright (Python) Language Server.
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							-- Overrides default diagnostic severity for specific issues.
							-- Helps reduce noise from less critical warnings.
							diagnosticSeverityOverrides = {
								reportGeneralTypeIssues = "warning",
								reportOptionalMemberAccess = "none",
								reportOptionalSubscript = "none",
								reportUnknownMemberType = "none",
								reportAttributeAccessIssue = "none",
							},
                            -- Explicitly tell pyright where to look for virtual environments.
                            -- Useful for tools like uv venv that create venvs in specific locations.
                            venvPath = vim.fn.expand("~/.cache/uv/venvs"),
                            venv = ".venv", -- Default venv directory name for uv.
						},
					},
				},
				-- Function executed before Pyright initializes.
				-- This logic attempts to find and set the correct Python interpreter path for the LSP.
				before_init = function(_, config)
					local venv_path = os.getenv("VIRTUAL_ENV")
					if venv_path then
						-- If VIRTUAL_ENV environment variable is set, use it directly.
						config.settings.python.pythonPath = venv_path .. "/bin/python"
						print("Pyright: Using VIRTUAL_ENV: " .. config.settings.python.pythonPath)
					else
						-- Otherwise, try to find a .venv in the current project root.
						local project_root = require("lspconfig.util").root_pattern("app.py", "models.py", "requirements.txt", ".git")(config.root_dir)
							if project_root then
								local local_venv_path = project_root .. "/.venv/bin/python"
								if vim.fn.filereadable(local_venv_path) then
									config.settings.python.pythonPath = local_venv_path
									print("Pyright: Using local .venv: " .. config.settings.python.pythonPath)
								else
									-- Fallback to system python if no local .venv found.
									config.settings.python.pythonPath = vim.fn.exepath("python")
									print("Pyright: Local .venv not found, falling back to system python: " .. config.settings.python.pythonPath)
								end
							else
								-- Fallback to system python if no project root found.
								config.settings.python.pythonPath = vim.fn.exepath("python")
								print("Pyright: Project root not found, falling back to system python: " .. config.settings.python.pythonPath)
							end
						end
					end,
				-- Defines patterns to detect the project root directory for Pyright.
				root_dir = lspconfig.util.root_pattern("app.py", "models.py", "requirements.txt", ".git"),
			},
			ts_ls = {}, -- Configuration for the TypeScript Language Server.
			html = { -- Configuration for the HTML Language Server.
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
				-- Filetypes for which the HTML LSP should be active.
				-- Includes Jinja-specific filetypes for broader templating support.
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
				-- Defines patterns to detect the project root for Jinja LSP.
				-- Expanded to include common Flask/Python project indicators for better template resolution.
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
			bashls = {}, -- Configuration for the Bash Language Server.
			jsonls = {}, -- Configuration for the JSON Language Server.
		}

		-- Loop through each configured server and set up its on_attach function and capabilities.
		for server, opts in pairs(servers) do
			opts.on_attach = on_attach
			opts.capabilities = capabilities
			lspconfig[server].setup(opts)
		end
	end,
}
