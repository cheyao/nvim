local options = {
  formatters_by_ft = {
    cpp = { "clang-format" },
    lua = { "stylua" },
  },
}

require("conform").setup(options)
