return {
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			local ls = luasnip
			local s = ls.snippet
			local t = ls.text_node
			local i = ls.insert_node

			-- Add the snippet for multiple filetypes (optional)
			for _, ft in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact" }) do
				ls.add_snippets(ft, {
					s("cl", {
						t("console.log("),
						i(1),
						t(")"),
					}),
				})
			end
			ls.add_snippets("go", {
				s("echo", {
					t("fmt.Println("),
					i(1),
					t(")"),
				}),
				s("enl", {
					t("if err != nil {"),
					t({ "", "\t" }),
					i(1),
					t({ "", "}" }),
				}),
			})
			ls.add_snippets("html", {
				s("!", {
					t({ "<!DOCTYPE html>", '<html lang="en">', "<head>", '  <meta charset="UTF-8">' }),
					t({ "", '  <meta name="viewport" content="width=device-width, initial-scale=1.0">' }),
					t({ "", "  <title>" }),
					i(1, "Document"),
					t({ "</title>", "</head>" }),
					t({ "", "<body>", "" }),
					i(0),
					t({ "", "</body>", "</html>" }),
				}),
			})

			-- HTTP/REST API documentation snippets
			ls.add_snippets("http", {
				-- GET request
				s("get", {
					t("GET "),
					i(1, "https://api.example.com/endpoint"),
					t({ "", "Content-Type: application/json", "", "" }),
				}),
				-- POST request
				s("post", {
					t("POST "),
					i(1, "https://api.example.com/endpoint"),
					t({ "", "Content-Type: application/json", "", "{", "  " }),
					i(2, '"key": "value"'),
					t({ "", "}" }),
				}),
				-- PUT request
				s("put", {
					t("PUT "),
					i(1, "https://api.example.com/endpoint"),
					t({ "", "Content-Type: application/json", "", "{", "  " }),
					i(2, '"key": "value"'),
					t({ "", "}" }),
				}),
				-- DELETE request
				s("delete", {
					t("DELETE "),
					i(1, "https://api.example.com/endpoint"),
					t({ "", "Content-Type: application/json", "", "" }),
				}),
				-- PATCH request
				s("patch", {
					t("PATCH "),
					i(1, "https://api.example.com/endpoint"),
					t({ "", "Content-Type: application/json", "", "{", "  " }),
					i(2, '"key": "value"'),
					t({ "", "}" }),
				}),
				-- Authorization header
				s("auth", {
					t("Authorization: Bearer "),
					i(1, "your_token_here"),
				}),
				-- Basic auth
				s("basic", {
					t("Authorization: Basic "),
					i(1, "base64_encoded_credentials"),
				}),
				-- API key header
				s("apikey", {
					t("X-API-Key: "),
					i(1, "your_api_key_here"),
				}),
				-- Content-Type JSON
				s("json", {
					t("Content-Type: application/json"),
				}),
				-- Content-Type form data
				s("form", {
					t("Content-Type: application/x-www-form-urlencoded"),
				}),
				-- User-Agent header
				s("ua", {
					t("User-Agent: "),
					i(1, "REST Client"),
				}),
				-- Variable definition
				s("var", {
					t("@"),
					i(1, "variable_name"),
					t(" = "),
					i(2, "value"),
				}),
				-- Environment separator
				s("env", {
					t("###"),
					t({ "", "# " }),
					i(1, "Environment: Development"),
					t({ "", "" }),
				}),
				-- Complete REST request template
				s("req", {
					t("### "),
					i(1, "Request Description"),
					t({ "", "" }),
					i(2, "GET"),
					t(" "),
					i(3, "https://api.example.com/endpoint"),
					t({ "", "Content-Type: application/json", "Authorization: Bearer " }),
					i(4, "{{token}}"),
					t({ "", "", "" }),
				}),
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					["<CR>"] = cmp.mapping.confirm({ select = true }),

					["<C-leader>"] = cmp.mapping.complete({}),

					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{
						name = "lazydev",
						group_index = 0,
					},
					{ name = "buffer" },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "emoji" },
				},
			})

			-- Enhanced completion for HTTP files
			cmp.setup.filetype("http", {
				sources = cmp.config.sources({
					{ name = "luasnip", priority = 1000 },
					{ name = "buffer", priority = 800 },
					{ name = "path", priority = 600 },
				}),
			})
		end,
	},
}