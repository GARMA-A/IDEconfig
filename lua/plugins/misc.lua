-- Simple plugins without complex configuration
return {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy", -- lazy-load on BufReadPre or VeryLazy
		config = function()
			require("colorizer").setup()
		end,
	},
	
	{
		"andymass/vim-matchup",
		event = "VeryLazy",
	},
	
	{
		"ekalinin/Dockerfile.vim",
		ft = "dockerfile",
	},
	
	{
		"stephpy/vim-yaml",
		ft = "yaml",
	},
	
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = { "markdown" },
		config = function()
			vim.g.mkdp_auto_start = 0
		end,
	},
	
	{
		"mattn/emmet-vim",
		-- Add event or filetype for lazy loading
		ft = { "html", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
		init = function()
			-- Set configuration during init
			vim.g.user_emmet_mode = "n" -- only enable normal mode functions
			vim.g.user_emmet_leader_key = "<C-,>" -- default <C-y>
		end,
	},
	
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	
	{
		"mbbill/undotree",
		keys = { { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undo Tree" } },
	},
	
	{
		"saecki/crates.nvim",
		tag = "stable",
		config = function()
			require("crates").setup()
		end,
	},
}