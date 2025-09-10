-- C# LSP configuration
return {
	omnisharp = {
		cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
		filetypes = { "cs", "csx", "vb" },
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern("*.sln", "*.csproj", ".git")(fname)
				or vim.fn.getcwd()
		end,
		settings = {
			FormattingOptions = {
				EnableEditorConfigSupport = true,
				OrganizeImports = true,
			},
			RoslynExtensionsOptions = {
				EnableAnalyzersSupport = true,
				EnableImportCompletion = true,
				EnableDecompilationSupport = true,
			},
			SdkIncludePrereleases = true,
		},
	},
}