vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "spectre_panel" },
    callback = function(args)
        vim.keymap.set("n", "q", "<cmd>q<cr>", { desc = "Quit", buffer = args.buf, silent = true })
    end,
})
