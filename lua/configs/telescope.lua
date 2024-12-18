local options = {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "-L",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  },
}

return options
