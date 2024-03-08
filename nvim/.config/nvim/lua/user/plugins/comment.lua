return {
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
                multiline = true, -- enable multine todo comments
                multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
                multiline_context = 5, -- extra lines that will be re-evaluated when changing a line
                before = "", -- "fg" or "bg" or empty
                keyword = "fg", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty.
                after = "fg", -- "fg" or "bg" or empty
                pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
                comments_only = true, -- uses treesitter to match keywords in comments only
                max_line_len = 120, -- ignore lines longer than this
                exclude = {}, -- list of file types to exclude highlighting
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
