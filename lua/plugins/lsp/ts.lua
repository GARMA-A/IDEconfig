-- TypeScript LSP configuration
return {
	tsserver = {
		settings = {
			typescript = {
				preferences = {
					-- Enable Next.js-style path aliases (requires tsconfig.json "baseUrl" and "paths")
					importModuleSpecifierPreference = "project=relative",
				},
				-- Enable React Server Components typing (Next.js 13+)
				experimental = {
					enableProjectDiagnostics = true,
				},
			},
		},
		-- Enable JSX/TSX support
		filetypes = { "typescript", "javascriptreact", "typescript", "typescriptreact" },
	},
}