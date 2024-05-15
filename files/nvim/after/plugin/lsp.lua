local lsp = require("lsp-zero").preset({})
local lspconfig = require("lspconfig")

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
end)

lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                disable = { "lowercase-global" }
            }
        }
    }
})

lsp.setup()
