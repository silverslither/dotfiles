local function _config()
    if vim.g.basic_terminal then return end

    vim.g.material_style = "deep ocean"

    if (vim.g.started_by_firenvim) then
        require("material").setup({
            styles = {
                comments = { italic = true }
            },
            disable = {
                term_colors = true,
            },
            custom_colors = function(colors)
                colors.editor.line_numbers = "#585e79"
                colors.editor.selection = "#3d4553"
                colors.editor.cursor = "#cccccc"
            end
        });

        vim.cmd.colorscheme("material")
    else
        require("material").setup({
            styles = {
                comments = { italic = true }
            },
            disable = {
                term_colors = true,
            },
            custom_colors = function(colors)
                colors.editor.bg = "#182030"
                colors.editor.active = "none"
                colors.backgrounds.sidebars = "none"
                colors.backgrounds.floating_windows = "none"
                colors.backgrounds.non_current_windows = "none"

                colors.editor.line_numbers = "#585e79"
                colors.editor.selection = "#3d4553"
                colors.editor.cursor = "#cccccc"
            end
        })

        vim.cmd.colorscheme("material")

        vim.cmd.highlight("Normal guibg=none")
        vim.cmd.highlight("StatusLineNC guibg=none")
        vim.cmd.highlight("StatusLineTermNC guibg=none")
    end

    theme = require("lualine.themes.material-nvim")
    theme.inactive.a.bg = "none"
    theme.inactive.b.bg = "none"
    theme.inactive.c.bg = "none"
    vim.g.material_lualine_theme = theme

    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        vim.api.nvim_set_hl(0, group, {})
    end
end

return {
    "marko-cerovac/material.nvim",
    config = _config
}
