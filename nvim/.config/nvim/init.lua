vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("user.options")
require("user.keymaps")
-- Options and key mappings are set before loading lazy.nvim
require("user.lazy")
