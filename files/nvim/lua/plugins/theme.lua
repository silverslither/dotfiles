function _config()
    if (vim.g.started_by_firenvim) then
        vim.g.material_style = "deep ocean"

        require("material").setup({
            styles = {
                comments = { italic = true }
            },
            custom_colors = function(colors)
                colors.editor.line_numbers = "#585e79"
                colors.editor.selection = "#3d4553"
                colors.editor.cursor = nil
            end
        });

        vim.cmd("colorscheme material")
        return
    end

    if (vim.g.vscode or os.getenv("TERM") == "linux") then return end

    vim.g.material_style = "deep ocean"

    require("material").setup({
        styles = {
            comments = { italic = true }
        },
        custom_colors = function(colors)
            colors.editor.bg = "#182030"
            colors.backgrounds.sidebars = "none"
            colors.backgrounds.floating_windows = "none"
            colors.backgrounds.non_current_windows = "none"

            colors.editor.line_numbers = "#585e79"

            colors.editor.selection = "#3d4553"
            colors.editor.cursor = nil
        end
    })

    vim.cmd("colorscheme material")

    vim.cmd("highlight Normal guibg=none")
    vim.cmd("highlight StatusLineNC guibg=none")
    vim.cmd("highlight StatusLineTermNC guibg=none")

    theme = require("lualine.themes.material-nvim")
    theme.inactive.a.bg = "none"
    theme.inactive.b.bg = "none"
    theme.inactive.c.bg = "none"
    vim.g.material_lualine_theme = theme
end

return {
    "marko-cerovac/material.nvim",
    config = _config
}
