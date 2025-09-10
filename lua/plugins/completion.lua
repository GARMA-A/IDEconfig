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
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp-signature-help",
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
		end,
	},
}