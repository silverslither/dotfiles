vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use {
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("mbbill/undotree")

    use {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },             -- Required
            { "williamboman/mason.nvim" },           -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },     -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "L3MON4D3/LuaSnip" },     -- Required
        }
    }

    use("saadparwaiz1/cmp_luasnip")

    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }
    use("marko-cerovac/material.nvim")
    use("NvChad/nvim-colorizer.lua")
    use("lervag/vimtex")
end)
