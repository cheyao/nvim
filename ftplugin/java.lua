local config = {
    cmd = { '/Users/ray/.local/share/nvim/mason/packages/jdtls/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)

local map = vim.keymap.set

map("n", "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>")
map("n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>")
map("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
map("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>")
map("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>")
map("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")
