return {
    "glacambre/firenvim",
    lazy = not vim.g.started_by_firenvim,
    build = function()
        require("firenvim")
        vim.fn["firenvim#install"](0)
    end,
    config = function()
        vim.g.firenvim_config = {
            localSettings = {
                [".*"] = {
                    takeover = "never",
                    filename = "{hostname}_{pathname}_{timestamp}.{extension}"
                }
            }
        }

        vim.o.guifont = "FiraMono Nerd Font Mono Medium:h12"

        vim.api.nvim_create_user_command("WriteLspFlags", function()
            vim.fn.writefile({ "-xc" }, "compile_flags.txt")
            vim.fn.writefile({ 'project-includes = ["**/*.py*", "**/*.txt"]' }, "pyrefly.toml")
        end, {})
    end
}
