local function _config()
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
                vim.keymap.set("n", "E", vim.lsp.buf.hover, opts)
            else
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            end
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
            vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
            vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
            vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
            vim.keymap.set({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end, opts)
            vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
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
        "saadparwaiz1/cmp_luasnip"
    },
    config = _config
}
