function _config()
    local default_config = require("lspconfig").util.default_config
    default_config.capabilities = vim.tbl_deep_extend(
        "force",
        default_config.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
    )

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local opts = { buffer = event.buf }
            if (vim.g.colemak_enabled) then
                vim.keymap.set("n", "E", function() vim.lsp.buf.hover() end, opts)
            else
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            end
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
            vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
            vim.keymap.set("n", "go", function() vim.lsp.buf.type_definition() end, opts)
            vim.keymap.set("n", "gs", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set("n", "<F2>", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, opts)
            vim.keymap.set("n", "<F4>", function() vim.lsp.buf.code_action() end, opts)
        end,
    })

    require("mason").setup({})
    require("mason-lspconfig").setup({
        handlers = {
            function(server)
                require("lspconfig")[server].setup({})
            end,

            lua_ls = function()
                require("lspconfig").lua_ls.setup({
                    settings = {
                        Lua = {
                            diagnostics = {
                                disable = { "lowercase-global", "undefined-global" }
                            },
                            format = {
                                enable = true,
                                defaultConfig = {
                                    max_line_length = "-1" -- works because formatter stores as size_t (unsigned)
                                }
                            }
                        }
                    }
                })
            end
        },
    })
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = _config
}
