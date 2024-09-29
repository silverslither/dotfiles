function _config()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
        if (vim.g.colemak_enabled) then
            vim.keymap.set("n", "E", function() vim.lsp.buf.hover() end, { buffer = bufnr, remap = false })
        end
    end)

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
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    config = _config
}
