return {
	-- 1. KEEP THIS: Your Chat setup (No changes needed here)
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "zbirenbaum/copilot.lua" }, -- Add this as a dependency
		},
		config = function()
			require("CopilotChat").setup({
				opts = {
					default_model = "gemini/gemini-2.5-flash",
					-- ... (Your existing Gemini config remains the same) ...
					providers = {
						gemini = {
							url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
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
								"gemini-2.5-pro",
								"gemini-2.5-flash",
								"gemini-1.5-pro-latest",
								"gemini-1.5-flash-latest",
							},
						},
					},
				},
			})
		end,
	},

	-- 2. REPLACE THIS: Remove 'github/copilot.vim' and use this instead
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter", -- Only load when you actually start typing
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true, -- Auto suggest like the original
					keymap = {
						accept = "<Tab>", -- Ensure Tab accepts the suggestion
					},
				},
				panel = { enabled = false },
			})
		end,
	},
}
