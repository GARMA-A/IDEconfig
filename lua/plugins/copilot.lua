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
				pattern = {"copilot-chat", "copilot_chat"}, -- Handle potential variations
				callback = function()
					-- Set up Tab to accept copilot suggestions in chat buffer
					vim.keymap.set("i", "<Tab>", function()
						-- Check if copilot.vim is available and has a suggestion
						if vim.fn.exists('*copilot#GetDisplayedSuggestion') == 1 then
							local suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
							if suggestion and suggestion.text and suggestion.text ~= "" then
								return vim.fn["copilot#Accept"]("")
							end
						end
						-- Fallback to default Tab behavior (including CopilotChat's completion)
						return "<Tab>"
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