vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move lines up/down and align
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- centered navigation remaps
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without yanking
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without yanking
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Allows Ctrl + C in addition to Esc
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Format current buffer with lsp
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Jump to next/prev error and keep centered
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>K", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>J", "<cmd>lprev<CR>zz")

-- Search and replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Jump between left/right window with h and l
vim.keymap.set('n', '<leader>h', ':wincmd h<CR>')
vim.keymap.set('n', '<leader>l', ':wincmd l<CR>')
vim.keymap.set('n', '<leader>j', ':wincmd j<CR>')
vim.keymap.set('n', '<leader>k', ':wincmd k<CR>')

-- Coding Headers Generation Shortcuts
vim.keymap.set('n', '<leader>-', 'yypwv$r-')
