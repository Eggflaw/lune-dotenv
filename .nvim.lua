local settings = vim.json.decode(io.open(".vscode/settings.json","r"):read("a"))

require("luau-lsp").config {
  sourcemap = {
    enabled = false,
  },
  settings = {
    ["luau-lsp"] = settings["luau-lsp"]
  }
}
