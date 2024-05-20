return {
    "LunarVim/bigfile.nvim",
    opts = {
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
