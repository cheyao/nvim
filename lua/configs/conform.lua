local options = {
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },
    verilog = { "verible" },
    systemverilog = { "verible" },
  },
  formatters = {
    verible = {
      command = "verible-verilog-format",
      args = { "--port_declarations_alignment=align", "--indentation_spaces=4", "-" },
      stdin = true,
    },
  },
}

require("conform").setup(options)
