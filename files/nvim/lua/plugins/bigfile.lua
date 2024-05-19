return {
    "LunarVim/bigfile.nvim",
    config = {
        filesize = 2, -- MB
        pattern = { "*" },
        features = {
            "indent_blankline",
            "illuminate",
            "lsp",
            "treesitter",
            "syntax",
            --"matchparen",
            "vimopts",
            "filetype",
        }
    }
}
