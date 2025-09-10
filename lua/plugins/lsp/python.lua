-- Python LSP configuration  
return {
	pyright = {
		settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					useLibraryCodeForTypes = true,
					typeCheckingMode = "basic",
				},
			},
		},
	},
}