return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main", -- 🔄 changed from 'canary' to 'main'
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("CopilotChat").setup({
				mappings = {
					complete = {
						detail = "Use @<Tab> or /<Tab> for options.",
						insert = "<Tab>",
					},
				},
			})
			
			-- Ensure Tab works for copilot suggestions in CopilotChat buffers
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "copilot-chat",
				callback = function()
					-- Set up Tab to accept copilot suggestions in chat buffer
					vim.keymap.set("i", "<Tab>", function()
						-- Try to accept copilot suggestion first
						local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
						if suggestion.text ~= "" then
							return vim.fn["copilot#Accept"]("")
						else
							-- Fallback to CopilotChat's own completion or regular tab
							return "<Tab>"
						end
					end, { buffer = true, expr = true, silent = true })
				end,
			})
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