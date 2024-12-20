function _config()
    if (vim.g.vscode or os.getenv("TERM") == "linux") then return end

    require("lualine").setup({
        options = {
            icons_enabled = true,
            theme = vim.g.material_lualine_theme,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {}
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    })
end

return {
    "nvim-lualine/lualine.nvim",
    commit = "640260d7c2d98779cab89b1e7088ab14ea354a02",
    dependencies = { "marko-cerovac/material.nvim", "nvim-tree/nvim-web-devicons" },
    config = _config
}
