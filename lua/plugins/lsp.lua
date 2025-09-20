return {
	-- LSP Plugins
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{ "j-hui/fidget.nvim", opts = {} },

			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			local servers = {
				html = {
					filetypes = { "html", "templ" },
				},
				css = {},
				gopls = {
					settings = {
						gopls = {
							usePlaceholders = true,
							completeUnimported = true,
						},
					},
				},
				sqlls = {
					cmd = { "sql-language-server", "up", "--method", "stdio" },
					filetypes = { "sql" },
					root_dir = function()
						return vim.loop.cwd()
					end,
				},

				yamlls = {},
				dockerls = {},

				-- ✅ FIXED: Changed from 'tsserver' to 'ts_ls' and added single_file_support
				ts_ls = {
					single_file_support = true, -- ✅ This enables single file support!
					settings = {
						typescript = {
							preferences = {
								-- Enable Next.js-style path aliases (requires tsconfig.json "baseUrl" and "paths")
								importModuleSpecifierPreference = "project=relative",
							},
							-- Enable React Server Components typing (Next.js 13+)
							experimental = {
								enableProjectDiagnostics = true,
							},
						},
						javascript = {
							preferences = {
								importModuleSpecifierPreference = "project=relative",
							},
						},
					},
					-- Enable JSX/TSX support and EJS files
					filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "html" },
				},

				tailwindcss = {
					filetypes = {
						"html",
						"css",
						"scss",
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"svelte",
						"vue",
					},
					init_options = {
						userLanguages = {
							typescriptreact = "typescript",
							javascriptreact = "javascript",
						},
					},
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									"tw`([^`]*)",
									"className=\\\\s*[\\\"']([^\\\"']*)",
									"class:\\\\s*[\\\"']([^\\\"']*)",
									"([\\\\w-]+)=\\\\s*[\\\"']([^\\\"']*)", -- For styled-components-like syntax
								},
							},
						},
					},
				},

				prisma = {
					cmd = { "prisma-language-server", "--stdio" },
					filetypes = { "prisma" },
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern("schema.prisma", ".git")(fname) or vim.fn.getcwd()
					end,
				},
				omnisharp = {
					cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
					filetypes = { "cs", "csx", "vb" },
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git")(fname)
							or vim.fn.getcwd()
					end,
					settings = {
						FormattingOptions = {
							EnableEditorConfigSupport = true,
							OrganizeImports = true,
						},
						RoslynExtensionsOptions = {
							EnableAnalyzersSupport = true,
							EnableImportCompletion = true,
							EnableDecompilationSupport = true,
						},
						SdkIncludePrereleases = true,
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"eslint", -- Keep this
				-- Remove "tsserver" - it's now "ts_ls" and handled by servers table
				"html",
				"css",
				"prismals",
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"typescript-language-server", -- ✅ Correct package name
					"eslint",
					"stylua",
					"html-lsp", -- ✅ HTML support (will handle EJS files)
					"css-lsp", -- ✅ CSS support
					"prettier",
					"gopls",
					"gofumpt",
					"tailwindcss-language-server",
					"yaml-language-server",
					"sqlls",
					"prisma-language-server",
					"angular-language-server",
					"omnisharp", -- Ensures OmniSharp is installed
					--"dotnet-format", -- Optional: C# formatter
				},
			})

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local opts = {
							capabilities = capabilities,
						}

						if server_name == "html" then
							-- Enable HTML LSP for EJS files
							opts.filetypes = { "html", "templ" }
							opts.settings = {
								html = {
									format = {
										templating = true,
										wrapLineLength = 120,
										wrapAttributes = "auto",
									},
									hover = {
										documentation = true,
										references = true,
									},
								},
							}
						end
						if server_name == "tailwindcss" or server_name == "tailwindcss-language-server" then
							opts.settings = {
								tailwindCSS = {
									experimental = {
										classRegex = {
											"tw`([^`]*)",
											"className=\\\\s*[\\\"']([^\\\"']*)",
											"class:\\\\s*[\\\"']([^\\\"']*)",
											"([\\\\w-]+)=\\\\s*[\\\"']([^\\\"']*)", -- styled-components
										},
									},
								},
							}
							opts.filetypes = {
								"html",
								"css",
								"scss",
								"javascript",
								"javascriptreact",
								"typescript",
								"typescriptreact",
								"svelte",
								"vue",
							}
							opts.init_options = {
								userLanguages = {
									typescriptreact = "html",
									javascriptreact = "html",
								},
							}
						end
						if server_name == "yamlls" then
							opts.settings = {
								yaml = {
									schemas = {
										["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
									},
									validate = true,
									hover = true,
									completion = true,
								},
							}
						end
						if server_name == "dockerls" then
							opts.settings = {
								docker = {
									languageserver = {
										formatter = {
											ignoreMultilineInstructions = true, -- Optional: Ignore multiline instructions for formatting
										},
									},
								},
							}
							opts.filetypes = { "dockerfile" } -- Ensure dockerls attaches to Dockerfile filetype
						end
						if server_name == "angularls" then
							opts.filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" }
							opts.root_dir = require("lspconfig").util.root_pattern("angular.json", "project.json")
							opts.cmd = {
								"ngserver",
								"--stdio",
								"--tsProbeLocations",
								vim.fn.expand("$PWD/node_modules"),
								"--ngProbeLocations",
								vim.fn.expand("$PWD/node_modules"),
							}
						end
						if server_name == "omnisharp" then
							opts.cmd = servers.omnisharp.cmd
							opts.filetypes = servers.omnisharp.filetypes
							opts.root_dir = servers.omnisharp.root_dir
							opts.settings = servers.omnisharp.settings
						end

						require("lspconfig")[server_name].setup(opts)
					end,
				},
			})
			vim.defer_fn(function()
				require("lspconfig").ts_ls.setup({
					capabilities = capabilities,
					single_file_support = true,
					on_attach = function(client, bufnr)
						print("ts_ls attached to buffer " .. bufnr)
					end,
					settings = {
						typescript = {
							preferences = {
								importModuleSpecifierPreference = "project-relative",
							},
						},
						javascript = {
							preferences = {
								importModuleSpecifierPreference = "project-relative",
							},
						},
					},
					filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "html" },
				})
			end, 100)
		end,
	},
}
