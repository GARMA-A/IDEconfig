return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main", -- 🔄 changed from 'canary' to 'main'
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("CopilotChat").setup({
				opts = {

					default_model = "gemini/gemini-2.5-flash",

					-- Define the Gemini provider
					providers = {
						gemini = {
							-- This is the OpenAI-compatible endpoint for Gemini (still correct!)
							url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
							-- This function reads your API key from the environment variable (still correct!)
							get_headers = function()
								local api_key = os.getenv("GEMINI_API_KEY")
								if not api_key then
									vim.notify("GEMINI_API_KEY environment variable not set", vim.log.levels.ERROR)
									return {}
								end
								return {
									["Authorization"] = "Bearer " .. api_key,
									["Content-Type"] = "application/json",
								}
							end,
							models = {
								"gemini-2.5-pro", -- The new high-capability model
								"gemini-2.5-flash", -- The new fast model
								"gemini-1.5-pro-latest", -- Still available
								"gemini-1.5-flash-latest", -- Still available
							},
						},
					},
				},
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
