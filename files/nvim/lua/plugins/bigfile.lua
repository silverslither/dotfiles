return {
    "LunarVim/bigfile.nvim",
    config = {
        filesize = 2, -- MB
        pattern = { "*" },
        features = {
            "lsp",
            "treesitter",
            "syntax",
            --"matchparen",
            "vimopts",
            "filetype",
        }
    }
}
