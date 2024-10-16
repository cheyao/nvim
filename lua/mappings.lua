require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>ss", "<cmd>:ClangdSwitchSourceHeader<cr>", { desc = 'Switch source header'})
map("n", "<leader>ft", "<cmd>:TodoTelescope<cr>", { desc = 'Find all todos'})

map("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

map("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

map("n", "K", function()
	vim.lsp.buf.hover()
end, { desc = "Show definition" })

vim.api.nvim_create_user_command("Shrug", ":r ~/.config/nvim/lua/shrug.txt", {});

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
