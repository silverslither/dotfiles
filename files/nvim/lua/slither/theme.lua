vim.g.material_style = "deep ocean"

require("material").setup({
    styles = {
        comments = { italic = true }
    },
    custom_colors = function(colors)
        colors.editor.bg = "#182030"
        colors.backgrounds.sidebars = colors.editor.bg
        colors.backgrounds.floating_windows = colors.editor.bg
        colors.backgrounds.non_current_windows = colors.editor.bg
        colors.editor.selection = "#3D4553"
    end
})

vim.cmd("colorscheme material")
