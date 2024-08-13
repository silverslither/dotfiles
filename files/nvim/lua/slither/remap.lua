vim.keymap.set({ "n", "x", "o" }, "j", "gj")
vim.keymap.set({ "n", "x", "o" }, "k", "gk")
vim.keymap.set({ "n", "x", "o" }, "0", "g0")
vim.keymap.set({ "n", "x", "o" }, "^", "g^")
vim.keymap.set({ "n", "x", "o" }, "$", "g$")
vim.keymap.set({ "n", "x", "o" }, "-", "g^")
vim.keymap.set({ "n", "x", "o" }, "+", "g$")

vim.keymap.set({ "n", "x", "o" }, "gj", "j")
vim.keymap.set({ "n", "x", "o" }, "gk", "k")
vim.keymap.set({ "n", "x", "o" }, "g0", "0")
vim.keymap.set({ "n", "x", "o" }, "g^", "^")
vim.keymap.set({ "n", "x", "o" }, "g-", "^")
vim.keymap.set({ "n", "x", "o" }, "g+", "$")

vim.keymap.set({ "n", "x" }, "<S-CR>", "-")

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<leader>s", [[:%s/\M\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("x", "<leader>s", [["9y:%s/\M<C-r>9/<C-r>9/gI<Left><Left><Left>]])

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "x" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y$")

vim.keymap.set({ "n", "x" }, "<leader>p", "\"+p")
vim.keymap.set({ "n", "x" }, "<leader>P", "\"+P")

vim.keymap.set({ "n", "x" }, "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>D", "\"_d$")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")

vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew)
vim.keymap.set("n", "<leader>tk", vim.cmd.tabclose)
vim.keymap.set("n", "<leader>ts", function() vim.cmd("tab split") end)
vim.keymap.set("n", "<leader>t-", "<CMD>-tabmove<CR>")
vim.keymap.set("n", "<leader>t+", "<CMD>+tabmove<CR>")
vim.keymap.set("n", "<leader>1", "1gt")
vim.keymap.set("n", "<leader>2", "2gt")
vim.keymap.set("n", "<leader>3", "3gt")
vim.keymap.set("n", "<leader>4", "4gt")
vim.keymap.set("n", "<leader>5", "5gt")
vim.keymap.set("n", "<leader>6", "6gt")
vim.keymap.set("n", "<leader>7", "7gt")
vim.keymap.set("n", "<leader>8", "8gt")
vim.keymap.set("n", "<leader>9", "9gt")
vim.keymap.set("n", "<leader>0", "10gt")

vim.keymap.set("n", "<Esc>", vim.cmd.noh)

vim.keymap.set({ "n", "i" }, "<F1>", "<nop>")
