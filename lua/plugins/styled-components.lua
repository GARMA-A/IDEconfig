-- Styled-components CSS autocompletion support
-- This configures ts_ls to use the @styled/typescript-styled-plugin for CSS autocompletion
-- inside styled-components template literals

-- Auto-install the styled-components TypeScript plugin globally if not present
local function ensure_styled_plugin_installed()
	-- Check if the plugin is already installed globally
	local result = vim.fn.system("npm list -g @styled/typescript-styled-plugin 2>&1")
	if not result:match("typescript%-styled%-plugin") then
		-- Install the plugin globally (silent, no output)
		vim.fn.jobstart({ "npm", "install", "-g", "@styled/typescript-styled-plugin" }, {
			on_exit = function(_, exit_code)
				if exit_code == 0 then
					vim.notify("Styled-components TypeScript plugin installed successfully", vim.log.levels.INFO)
				end
			end,
		})
	end
end

-- Run async to not block startup
vim.defer_fn(function()
	ensure_styled_plugin_installed()
end, 2000)

return {}
