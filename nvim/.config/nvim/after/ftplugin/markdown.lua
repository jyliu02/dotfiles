vim.o.conceallevel = 2
vim.o.shiftwidth = 2
vim.o.textwidth = 100
vim.o.colorcolumn = "+1"

vim.keymap.set("n", "<leader>gw", function()
  vim.cmd("normal! mzggVGgw'z")
  require("conform").format()
end)
