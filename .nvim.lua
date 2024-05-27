local settings = vim.json.decode(io.open(".vscode/settings.json", "r"):read("a"))

-- make sure you enabled vim.o.enabled in your neovim config
require("luau-lsp").config({
	sourcemap = {
		enabled = false,
	},
	server = {
		settings = {
			["luau-lsp"] = {
				require = {
					directoryAliases = settings["luau-lsp.require.directoryAliases"],
					mode = settings["luau-lsp.require.mode"],
				},
			},
		},
	},
})
