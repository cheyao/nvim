local map=vim.keymap.set

map("n", "<leader>m", "<Cmd>ClangdMemoryUsage<CR>", { desc = "Show memory usage" });
map("n", "<leader>a", "<Cmd>ClangdAST<CR>", { desc = "Show AST" });
map("n", "<leader>ss", "<cmd>ClangdSwitchSourceHeader<cr>", { desc = "Switch source header" })
