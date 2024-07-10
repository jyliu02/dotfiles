-- Remap <Space> as <leader>
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "

vim.keymap.set({ "n", "i" }, "<Esc>", "<cmd>noh<cr><esc>") -- Clear search highlights

vim.keymap.set({ "n", "v" }, "<C-w>>", "<C-w>10>")
vim.keymap.set({ "n", "v" }, "<C-w><", "<C-w>10<")
vim.keymap.set({ "n", "v" }, "<C-w>-", "<C-w>10-")
vim.keymap.set({ "n", "v" }, "<C-w>+", "<C-w>10+")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "J", "mzJ`z") -- Join lines and keep cursor in the original place.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "[q", "<cmd>cprev<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { noremap = true, silent = true })
