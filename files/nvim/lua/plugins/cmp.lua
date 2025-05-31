local function _config()
    local ls = require("luasnip")
    local cmp = require("cmp")

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-k>"] = cmp.mapping.select_prev_item(),

            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm({ select = true })
                elseif ls.locally_jumpable(1) then
                    ls.jump(1)
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<C-Space>"] = cmp.mapping(function(_)
                if ls.locally_jumpable(1) then
                    ls.jump(1)
                end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if ls.locally_jumpable(-1) then
                    ls.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" })
        }),

        snippet = {
            expand = function(args)
                ls.lsp_expand(args.body)
            end
        },

        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip", keyword_length = 1, keyword_pattern = [[[^]0-9A-Za-z()[{}|$&.\ ][^][(){} ]\+]] } -- only for latex
        },

        enabled = function()
            return vim.api.nvim_get_mode().mode ~= "c" -- mem leak on large files when in command mode
        end
    })

    local default_config = require("lspconfig").util.default_config
    default_config.capabilities = vim.tbl_deep_extend(
        "force",
        default_config.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
    )
end

return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip"
    },
    config = _config
}
