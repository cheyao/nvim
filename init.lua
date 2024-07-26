-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.bigfile_size = 1024 * 1024 * 1.5
vim.g.autoformat = true

vim.opt.termguicolors = true
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

vim.o.relativenumber = true
vim.o.number = true
vim.o.expandtab = false
vim.o.ignorecase = true
vim.o.list = true
vim.o.smarttab = true
vim.o.shiftwidth = 8
vim.o.smartcase = true
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.smoothscroll = true
vim.o.foldmethod = "expr"
vim.o.foldtext = ""
vim.o.smartindent = true
vim.o.cursorline = true
vim.o.rtp = vim.o.rtp .. ",/usr/local/opt/fzf"
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

local map=vim.keymap.set

map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

map("n", "]g", vim.diagnostic.goto_next, { desc = "Next warning" })
map("n", "[g", vim.diagnostic.goto_prev, { desc = "Prev warning" })

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= "bigfile"
            and path
            and vim.fn.getfsize(path) > vim.g.bigfile_size
            and "bigfile"
          or nil
      end,
    },
  },
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	    { "nvim-tree/nvim-tree.lua", lazy = false, dependencies = { "nvim-tree/nvim-web-devicons" }, config = function() require("nvim-tree").setup {} end },
	    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	    { "neovim/nvim-lspconfig" },
	    { "hrsh7th/cmp-nvim-lsp" },
	    { "hrsh7th/cmp-buffer" },
	    { "hrsh7th/cmp-cmdline" },
	    { "hrsh7th/nvim-cmp", dependencies = { "saadparwaiz1/cmp_luasnip", "L3MON4D3/LuaSnip" } },
	    { "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
	    { "saadparwaiz1/cmp_luasnip" },
	    { "p00f/clangd_extensions.nvim" },
	    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
	    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons"} },
	    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	    { "romgrk/barbar.nvim", dependencies = { "lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons", }, init = function() vim.g.barbar_auto_setup = false end, version = "^1.0.0" },
	    { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, lazy = false },
	    { "folke/which-key.nvim", event = "VeryLazy", opts = {}, dependencies = { "echasnovski/mini.icons" } }
    },
    install = { colorscheme = { "habamax" } },
    checker = { enabled = false },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')

require("lspconfig").clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
        capabilities = capabilities
      })

local luasnip = require('luasnip');
-- luasnip.setup();
local cmp = require("cmp")
cmp.setup ({
  snippet = {
    expand = function(args)
	luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
  }, {
      { name = 'buffer' },
  }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
})


require("catppuccin").setup({ flavour = "macchiato" })
require("lualine").setup()
require("todo-comments").setup()
require("barbar").setup({
	sidebar_filetypes = {
		NvimTree = true,
	},
})
require("clangd_extensions").setup()

-- require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ include = { "c", "cpp", "glsl", "python" } })

require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "vim", "vimdoc", "cpp", "glsl", "python" },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	}
})

vim.cmd.colorscheme "catppuccin"

local builtin = require("telescope.builtin")

map("n", "<leader>ff", builtin.git_files, { desc = "Find files" })
map("n", "<leader>fa", builtin.find_files, { desc = "Find all files" })
map("n", "<leader>fw", builtin.live_grep, { desc = "Find grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
map("n", "<leader>ft", "<Cmd>TodoTelescope<cr>", { desc = "Find todos" })

-- " Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>");
map("n", "<A-.>", "<Cmd>BufferNext<CR>");

map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>");
map("n", "<Tab>", "<Cmd>BufferNext<CR>");

-- " Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>");
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>");

-- " Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>");
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>");
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>");
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>");
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>");
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>");
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>");
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>");
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>");
map("n", "<A-0>", "<Cmd>BufferLast<CR>");

-- " Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>");

-- " Close buffer
map("n", "<A-w>", "<Cmd>BufferClose<CR>");
map("n", "<A-x>", "<Cmd>BufferClose<CR>");
map("n", "<leader>x", "<Cmd>BufferClose<CR>");
-- " Restore buffer
map("n", "<A-s-t>", "<Cmd>BufferRestore<CR>");

map("n", "<A-n>", "<Cmd>NvimTreeOpen<CR>");

