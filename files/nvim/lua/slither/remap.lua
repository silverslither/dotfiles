-- movement
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
vim.keymap.set({ "n", "x", "o" }, "g$", "$")
vim.keymap.set({ "n", "x", "o" }, "g-", "^")
vim.keymap.set({ "n", "x", "o" }, "g+", "$")

function H() vim.cmd("norm! " .. math.max(1, math.floor(0.5 * vim.fn.getwininfo(vim.fn.win_getid())[1].height - 1)) .. "gkzzm'") end
function L() vim.cmd("norm! " .. math.max(1, math.floor(0.5 * vim.fn.getwininfo(vim.fn.win_getid())[1].height - 1)) .. "gjzzm'") end
vim.keymap.set({ "n", "x" }, "<C-u>", H);
vim.keymap.set({ "n", "x" }, "<C-d>", L);
vim.keymap.set({ "n", "x" }, "H", H);
vim.keymap.set({ "n", "x" }, "L", L);

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "x" }, "<S-CR>", "-")

-- editing
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<leader>s", [[:%s/\V\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("x", "<leader>s", [["9y:%s/\V<C-r>9/<C-r>9/gI<Left><Left><Left>]])

vim.keymap.set({ "n", "x" }, "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y$")

vim.keymap.set({ "n", "x" }, "<leader>p", "\"+p")
vim.keymap.set({ "n", "x" }, "<leader>P", "\"+P")

vim.keymap.set({ "n", "x" }, "<leader>d", "\"_d")
vim.keymap.set("n", "<leader>D", "\"_d$")

-- tab navigation
vim.keymap.set("n", "<leader>tn", vim.cmd.tabnew)
vim.keymap.set("n", "<leader>tc", vim.cmd.tabclose)
vim.keymap.set("n", "<leader>ts", function() vim.cmd("tab split") end)
vim.keymap.set("n", "<leader>t-", ":-tabmove<CR>")
vim.keymap.set("n", "<leader>t+", ":+tabmove<CR>")

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

-- window navigation
vim.keymap.set({ "n", "x", "o" }, "<C-w>", "<nop>", { nowait = true })
vim.keymap.set({ "n", "x", "o" }, "<C-w>+", "<C-w>+")
vim.keymap.set({ "n", "x", "o" }, "<C-w>-", "<C-w>-")
vim.keymap.set({ "n", "x", "o" }, "<C-w><", "<C-w><")
vim.keymap.set({ "n", "x", "o" }, "<C-w>=", "<C-w>=")
vim.keymap.set({ "n", "x", "o" }, "<C-w>>", "<C-w>>")

vim.keymap.set({ "n", "x", "o" }, "<C-w>h", "<C-w>h")
vim.keymap.set({ "n", "x", "o" }, "<C-w>H", "<C-w>H")
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-h>", "<C-w><C-h>")

vim.keymap.set({ "n", "x", "o" }, "<C-w>j", "<C-w>j")
vim.keymap.set({ "n", "x", "o" }, "<C-w>J", "<C-w>J")
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-j>", "<C-w><C-j>")

vim.keymap.set({ "n", "x", "o" }, "<C-w>k", "<C-w>k")
vim.keymap.set({ "n", "x", "o" }, "<C-w>K", "<C-w>K")
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-k>", "<C-w><C-k>")

vim.keymap.set({ "n", "x", "o" }, "<C-w>l", "<C-w>l")
vim.keymap.set({ "n", "x", "o" }, "<C-w>L", "<C-w>L")
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-l>", "<C-w><C-l>")

vim.keymap.set({ "n", "x", "o" }, "<C-w>r", "<C-w>r")
vim.keymap.set({ "n", "x", "o" }, "<C-w>R", "<C-w>R")
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-r>", "<C-w><C-r>")

vim.keymap.set({ "n", "x", "o" }, "<C-w>s", vim.cmd.vsplit)
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-s>", vim.cmd.vsplit)

vim.keymap.set({ "n", "x", "o" }, "<C-w>t", "<C-w>T")
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-t>", "<C-w>T")

vim.keymap.set({ "n", "x", "o" }, "<C-w>q", "<C-w>c")
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-q>", "<C-w><C-c>")

vim.keymap.set({ "n", "x", "o" }, "<C-w>n", vim.cmd.vnew)
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-n>", vim.cmd.vnew)

vim.keymap.set({ "n", "x", "o" }, "<C-w>w", "<C-w>w")
vim.keymap.set({ "n", "x", "o" }, "<C-w>W", "<C-w>W")
vim.keymap.set({ "n", "x", "o" }, "<C-w><C-w>", "<C-w><C-w>")

-- misc
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<Backspace>", "<C-^>");
vim.keymap.set("n", "<Esc>", vim.cmd.noh)
vim.keymap.set("n", "<leader>h", function() vim.cmd("TSBufDisable highlight") end)
vim.keymap.set({ "n", "i" }, "<F1>", "<nop>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
