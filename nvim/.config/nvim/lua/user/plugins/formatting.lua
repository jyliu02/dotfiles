return {
    "stevearc/conform.nvim",
    event = "BufReadPre",
    config = function()
        local conform = require("conform")
        conform.setup({
            formatters_by_ft = {
                -- Conform will run multiple formatters sequentially
                -- Use a sub-list to run only the first available formatter
                lua = { "stylua" },
                python = { "yapf" },
                go = { "gofmt" },
                ocaml = { "ocamlformat" },
            },
            format_on_save = {
                lsp_fallback = true,
                timeout_ms = 1000,
            },
            notify_on_error = false,
        })
        conform.formatters.stylua = {
            prepend_args = {
                "--indent-type",
                "Spaces",
                "--quote-style",
                "ForceDouble",
                "--column-width",
                "100",
            },
        }
    end,
}
