return {
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
        "echasnovski/mini.surround",
        keys = function(_, keys)
            -- Populate the keys based on the user's options
            local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local mappings = {
                { opts.mappings.add,            desc = "Add surrounding",                     mode = { "n", "v" } },
                { opts.mappings.delete,         desc = "Delete surrounding" },
                { opts.mappings.find,           desc = "Find right surrounding" },
                { opts.mappings.find_left,      desc = "Find left surrounding" },
                { opts.mappings.highlight,      desc = "Highlight surrounding" },
                { opts.mappings.replace,        desc = "Replace surrounding" },
                { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
            }
            mappings = vim.tbl_filter(function(m)
                return m[1] and #m[1] > 0
            end, mappings)
            return vim.list_extend(mappings, keys)
        end,
        opts = {
            mappings = {
                add = "gsa",            -- Add surrounding in Normal and Visual modes
                delete = "gsd",         -- Delete surrounding
                find = "gsf",           -- Find surrounding (to the right)
                find_left = "gsF",      -- Find surrounding (to the left)
                highlight = "gsh",      -- Highlight surrounding
                replace = "gsr",        -- Replace surrounding
                update_n_lines = "gsn", -- Update `n_lines`
            },
            n_lines = 100,
        },
    },
    {
        "numToStr/Comment.nvim",
        event = "BufReadPre",
        opts = {},
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre" },
        opts = {
            signs = false,
            merge_keywords = false,
            keywords = {
                FIXME = { color = "error", alt = { "BUG", "ISSUE", "ERROR" } },
                TODO = { color = "todo" },
                WARN = { color = "warning", alt = { "WARNING" } },
                NOTE = { color = "hint", alt = { "INFO" } },
            },
            highlight = {
                multiline = true,                -- enable multine todo comments
                multiline_pattern = "^.",        -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 10,          -- extra lines that will be re-evaluated when changing a line
                before = "",                     -- "fg" or "bg" or empty
                keyword = "fg",                  -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty.
                after = "fg",                    -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true,            -- uses treesitter to match keywords in comments only
                max_line_len = 120,              -- ignore lines longer than this
                exclude = {},                    -- list of file types to exclude highlighting
            },
            colors = {
                error = { "DiagnosticError" },
                warning = { "DiagnosticWarn" },
                hint = { "DiagnosticHint" },
                todo = { "Constant" },
            },
        },
    },
}
