-- Remap <Space> as <leader>
vim.keymap.set("", "<Space>", "<Nop>", { desc = "" })
vim.g.mapleader = " "

-- Clear search highlights
vim.keymap.set({ "n", "i" }, "<Esc>", "<cmd>noh<cr><esc>")

-- Resize window faster
vim.keymap.set({ "n", "v" }, "<C-w>>", "<C-w>10>")
vim.keymap.set({ "n", "v" }, "<C-w><", "<C-w>10<")
vim.keymap.set({ "n", "v" }, "<C-w>-", "<C-w>10-")
vim.keymap.set({ "n", "v" }, "<C-w>+", "<C-w>10+")

-- Better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set({ "n", "v" }, "]t", vim.cmd.tabnext)
vim.keymap.set({ "n", "v" }, "[t", vim.cmd.tabprevious)

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")
