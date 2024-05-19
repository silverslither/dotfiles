function _config()
    local ls = require("luasnip")

    ls.config.set_config({
        region_check_events = "InsertEnter",
        delete_check_events = "InsertLeave"
    })

    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })
end

return {
    "L3MON4D3/LuaSnip",
    config = _config
}
