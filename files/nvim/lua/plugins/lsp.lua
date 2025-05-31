local function _config()
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local opts = { buffer = event.buf }
            if (vim.g.colemak_enabled) then
                vim.keymap.set("n", "E", vim.lsp.buf.hover, opts)
            else
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            end
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<F1>", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
            vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, opts)
            vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
        end,
    })

    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                diagnostics = {
                    disable = { "lowercase-global", "undefined-global" }
                },
                format = {
                    enable = true,
                    defaultConfig = {
                        max_line_length = "65536"
                    }
                }
            }
        }
    })

    require("mason").setup()
    require("mason-lspconfig").setup()
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    config = _config
}
