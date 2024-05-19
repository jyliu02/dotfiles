vim.api.nvim_create_autocmd("FileType", {
    pattern = { "help", "spectre_panel" },
    callback = function(args)
        vim.keymap.set("n", "q", "<cmd>q<cr>", { desc = "Quit", buffer = args.buf, silent = true })
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
    callback = function()
        if
            vim.bo.modified
            and not vim.bo.readonly
            and vim.fn.expand("%") ~= ""
            and vim.bo.buftype == ""
        then
            vim.api.nvim_command("silent update")
        end
    end,
})

