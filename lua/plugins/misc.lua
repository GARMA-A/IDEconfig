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
		config = function()
			-- Configure vim-matchup for better HTML tag navigation
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			vim.g.matchup_surround_enabled = 1
			
			-- Enable HTML tag matching
			vim.g.matchup_matchparen_deferred = 1
			vim.g.matchup_matchparen_hi_surround_always = 1
			
			-- Configure for HTML and related file types
			vim.g.matchup_delim_start_plaintext = 0
			
			-- Enable better matching for HTML/XML tags
			vim.g.matchup_matchparen_enabled = 1
			vim.g.matchup_motion_enabled = 1
			vim.g.matchup_text_obj_enabled = 1
			
			-- Optimize performance for large files
			vim.g.matchup_matchparen_timeout = 300
			vim.g.matchup_matchparen_insert_timeout = 60
			
			-- Ensure proper highlighting and navigation
			vim.g.matchup_delim_nomids = 0  -- Allow middle delimiters (useful for some HTML constructs)
		end,
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
		ft = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
		init = function()
			-- Optional: Customize for Next.js JSX/TSX (e.g., className instead of class)
			vim.g.user_emmet_settings = {
				typescriptreact = {
					extends = "jsx",
					attributes = {
						["className"] = "class", -- Expand class to className
					},
				},
				javascriptreact = {
					extends = "jsx",
					attributes = {
						["className"] = "class",
					},
				},
			}
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
		ft = { "toml" },
		config = function()
			require("crates").setup({
				completion = {
					cmp = {
						enabled = true,
					},
				},
			})
			require("cmp").setup.buffer({
				sources = { { name = "crates" } },
			})
		end,
	},
	
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	
	{
		"elentok/format-on-save.nvim",
		config = function()
			require("format-on-save").setup({
				formatters = {
					{
						filename_pattern = { "*.tsx", "*.jsx", "*.ts", "*.js" },
						command = "eslint --fix --quiet",
						-- For projects with local ESLint installation:
						command = "./node_modules/.bin/eslint --fix --quiet $FILE_PATH",
					},
				},
				-- Optional: Enable format on save by default
				format_on_save = true,
			})
		end,
	},
}