function _config()
    require("nvim-treesitter.configs").setup({
        ensure_installed = { "javascript", "python", "sql", "c", "lua", "vim", "vimdoc", "query" },
        sync_install = false,
        auto_install = false,
        highlight = {
            enable = true,
            disable = { "latex" },
            additional_vim_regex_highlighting = false,
        }
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = _config
}
