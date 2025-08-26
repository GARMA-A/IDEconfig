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
			-- Enable matchup for better tag navigation
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
			
			-- Tell matchup that Svelte files should use HTML-style tag matching
			vim.g.matchup_override_vimtex = 1
			
			-- Configure matchup to work with Svelte files
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "svelte",
				callback = function()
					-- Enable all matchup features for Svelte files
					vim.b.matchup_matchparen_enabled = 1
					vim.b.matchup_motion_enabled = 1
					vim.b.matchup_text_obj_enabled = 1
					
					-- Ensure Svelte files are treated like HTML for tag matching
					vim.b.matchup_matchpref = { html = 1 }
				end,
			})
			
			-- Also ensure HTML files work properly
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "html", "xml" },
				callback = function()
					vim.b.matchup_matchparen_enabled = 1
					vim.b.matchup_motion_enabled = 1
					vim.b.matchup_text_obj_enabled = 1
				end,
			})
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
		ft = { "html", "css", "scss", "javascriptreact", "typescriptreact", "svelte" },
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
				svelte = {
					extends = "html",
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
		ft = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
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