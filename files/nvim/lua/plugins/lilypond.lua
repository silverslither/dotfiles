local function _config()
    require("nvls").setup({
        lilypond = {
            highlights = nil,
            mappings = {
                player = "<leader>lp",
                compile = "<leader>ll",
                open_pdf = "<leader>lo",
                switch_buffers = "<leader>lb",
                insert_version = "<leader>iv",
            },
            options = {
                pdf_viewer = "zathura",
            },
        },
        latex = nil,
        texinfo = nil,
        player = {
            mappings = {
                quit = "q",
                play_pause = "p",
                backward = "j",
                small_backward = "J",
                forward = "k",
                small_forward = "K",
                loop = nil,
                decrease_speed = nil,
                increase_speed = nil,
                halve_speed = nil,
                double_speed = nil,
            },
            options = {
                fluidsynth_flags = {
                    "-g", "1"
                },
                ffmpeg_flags = {
                    "-c:a", "flac",
                    "-compression_level", "12"
                },
                audio_format = "flac",
            }
        }
    })

    local augroup = vim.api.nvim_create_augroup("slither.lilypond", { clear = true })

    vim.api.nvim_create_autocmd("BufEnter", {
        group = augroup,
        command = "syntax sync fromstart",
        pattern = { "*.ly", "*.ily" }
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
        group = augroup,
        command = "LilyCmp",
        pattern = { "*.ly", "*.ily" }
    })
end

return {
    "martineausimon/nvim-lilypond-suite",
    config = _config
}
