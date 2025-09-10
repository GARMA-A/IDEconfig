-- JavaScript LSP configuration
return {
	-- TypeScript server also handles JavaScript
	tsserver = {
		settings = {
			javascript = {
				preferences = {
					importModuleSpecifierPreference = "project=relative",
				},
			},
		},
		filetypes = { "javascript", "javascriptreact" },
	},
}