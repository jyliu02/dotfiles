return {
    { "HiPhish/rainbow-delimiters.nvim", event = "BufReadPre" },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPre" },
        config = function()
            require("ibl").setup({
                indent = { char = "▏" },
                scope = { enabled = false },
                exclude = {
                    filetypes = {
                        "help",
                        "lazy",
                        "oil_preview",
                    },
                },
            })
        end,
    },
    {
        "echasnovski/mini.indentscope",
        event = { "BufReadPre" },
        opts = {
            symbol = "▏",
            options = { try_as_border = true },
            draw = {
                animation = function()
                    return 0
                end,
            },
        },
        init = function()
            -- filetypes to ignore
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "lazy",
                    "oil_preview",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
            if vim.fn.argc(-1) > 0 then
                -- set an empty statusline till lualine loads
                vim.o.statusline = " "
            else
                -- hide the statusline on the starter page
                vim.o.laststatus = 0
            end
        end,
        config = function()
            vim.o.laststatus = vim.g.lualine_laststatus

            require("lualine").setup({
                options = {
                    theme = "auto",
                    globalstatus = true,
                    disabled_filetypes = { statusline = { "undotree", "diff" } },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                extensions = { "man", "quickfix", "lazy", "oil" },
            })
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
    },
    {
        "j-hui/fidget.nvim", -- lsp progress
        opts = {
            progress = {
                display = {
                    render_limit = 8,
                },
            },
        },
    },
}
