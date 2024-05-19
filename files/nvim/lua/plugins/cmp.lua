function _config()
    local ls = require("luasnip")
    local cmp = require("cmp")

    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.confirm({ select = true })
                elseif ls.locally_jumpable(1) then
                    ls.jump(1)
                else
                    fallback()
                end
            end, { "i", "s" }),

            ["<C-Space>"] = cmp.mapping(function(fallback)
                if ls.locally_jumpable(1) then
                    ls.jump(1)
                    --else
                    --fallback()
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
            { name = "luasnip", keyword_length = 1, keyword_pattern = [[[^0-9A-Za-z$& ][^ ]\+]] }
        }
    })
end

return {
    "hrsh7th/nvim-cmp",
    config = _config
}
