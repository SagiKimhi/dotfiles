local spider = require('spider')
vim.keymap.set({ "n", "o", "x" }, "w", function() spider.motion('w') end, { desc = "Spider-w" })
vim.keymap.set( { "n", "o", "x" }, "e",function() spider.motion('e') end, { desc = "Spider-e" })
vim.keymap.set( { "n", "o", "x" }, "b",function() spider.motion('b') end, { desc = "Spider-b" })
