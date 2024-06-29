return {
    { "tpope/vim-sleuth" },
    { -- Collection of various small independent plugins/modules
        "echasnovski/mini.nvim",
        config = function()
            -- Add/delete/replace surroundings (brackets, quotes, etc.)
            --
            -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
            -- - sd'   - [S]urround [D]elete [']quotes
            -- - sr)'  - [S]urround [R]eplace [)] [']
            require("mini.surround").setup()

            -- Simple and easy statusline.
            --  You could remove this setup call if you don't like it,
            --  and try some other statusline plugin
            local statusline = require("mini.statusline")
            -- set use_icons to true if you have a Nerd Font
            statusline.setup()

            -- You can configure sections in the statusline by overriding their
            -- default behavior. For example, here we set the section for
            -- cursor location to LINE:COLUMN
            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v"
            end
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = { "BufReadPre", "BufNewFile" },
        init = function()
            vim.o.foldcolumn = "0" -- '0' is not bad
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
        config = function()
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
            vim.cmd("hi! link UfoFoldedEllipsis Comment") -- No idea why I have to link this manually, but at least it works.

            require("ufo").setup({
                open_fold_hl_timeout = 0,
                provider_selector = function(bufnr, filetype, buftype)
                    if filetype == "markdown" then
                        return { "treesitter", "indent" }
                    else
                        return { "lsp", "indent" }
                    end
                end,
            })
        end,
    },
    {
        "mbbill/undotree",
        cmd = { "UndotreeToggle" },
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "UndoTree", silent = true },
        },
        init = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end,
    },
    {
        "alexghergh/nvim-tmux-navigation",
        event = "VeryLazy",
        config = function()
            local nav = require("nvim-tmux-navigation")

            nav.setup({
                disable_when_zoomed = true,
            })

            vim.keymap.set({ "n", "v" }, "<C-h>", nav.NvimTmuxNavigateLeft)
            vim.keymap.set({ "n", "v" }, "<C-j>", nav.NvimTmuxNavigateDown)
            vim.keymap.set({ "n", "v" }, "<C-k>", nav.NvimTmuxNavigateUp)
            vim.keymap.set({ "n", "v" }, "<C-l>", nav.NvimTmuxNavigateRight)
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        event = "VeryLazy",
    },
}
