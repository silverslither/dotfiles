function _config()
    require("mason").setup()
    require("mason-lspconfig").setup()

    local lsp_zero = require("lsp-zero").preset({})
    local lspconfig = require("lspconfig")

    lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
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

    lsp_zero.setup()
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
