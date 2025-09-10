return {
	"ray-x/go.nvim",
	dependencies = { -- Optional dependencies
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("go").setup({
			gofmt = "gofumpt", -- Use 'gofumpt' for formatting
			max_line_len = 120,
			tag_transform = false,
			test_dir = "",
			comment_placeholder = "   ",
			lsp_cfg = true,
			lsp_on_attach = true,
			dap_debug = true,
		})
	end,
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
}