return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main", -- 🔄 changed from 'canary' to 'main'
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("CopilotChat").setup({})
		end,
	},
	{
		"github/copilot.vim",
		dependencies = {},
		event = "VimEnter",
		config = function()
			vim.g.copilot_no_tab_map = false
			vim.g.copilot_workspace_folders = { vim.fn.getcwd() }
		end,
	},
}