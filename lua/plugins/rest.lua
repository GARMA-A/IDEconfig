-- REST client and HTTP documentation support
return {
	-- Main REST client plugin for .rest files
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = false,
				-- Result split in vertical
				result_split_in_place = false,
				-- Keep the http file buffer above|left when split horizontal|vertical
				stay_in_current_window_after_split = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					show_curl_command = false,
					show_http_info = true,
					show_headers = true,
					-- table of curl `--write-out` variables or false if disabled
					show_statistics = false,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
						end
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = '.env',
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})

			-- Keymaps for REST operations
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {"http", "rest"},
				callback = function()
					local opts = { buffer = true, silent = true }
					vim.keymap.set("n", "<leader>rr", "<Plug>RestNvim", vim.tbl_extend("force", opts, { desc = "Run REST request under cursor" }))
					vim.keymap.set("n", "<leader>rl", "<Plug>RestNvimLast", vim.tbl_extend("force", opts, { desc = "Run last REST request" }))
					vim.keymap.set("n", "<leader>rp", "<Plug>RestNvimPreview", vim.tbl_extend("force", opts, { desc = "Preview REST request as curl command" }))
				end,
			})
		end,
	},

	-- HTTP syntax highlighting
	{
		"nickel-lang/vim-http-syntax",
		ft = {"http", "rest"},
	},
}