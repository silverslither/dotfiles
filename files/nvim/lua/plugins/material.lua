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

        for _, autocmd in ipairs(vim.api.nvim_get_autocmds({
            group = "nvim.terminal",
            event = "TermRequest",
        })) do
            if autocmd.desc == "Handles OSC foreground/background color requests" then
                vim.api.nvim_del_autocmd(autocmd.id)
            end
        end
        vim.api.nvim_create_autocmd("TermRequest", {
            group = vim.api.nvim_create_augroup("slither.terminal-colors", { clear = true }),
            callback = function(event)
                local command = ({ ["\27]10;?"] = 10, ["\27]11;?"] = 11 })[event.data.sequence]
                local channel = vim.bo[event.buf].channel
                if not command or channel == 0 then return end

                local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
                local color = command == 10 and (normal.fg or 0xd3dae3) or (normal.bg or 0x182030)
                vim.api.nvim_chan_send(channel, string.format(
                    "\27]%d;rgb:%04x/%04x/%04x%s",
                    command,
                    math.floor(color / 0x10000) % 0x100 * 0x101,
                    math.floor(color / 0x100) % 0x100 * 0x101,
                    color % 0x100 * 0x101,
                    event.data.terminator
                ))
            end,
        })
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
