return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("configs.conform")
		end,
	}, {
	"neovim/nvim-lspconfig",
	config = function()
		require("nvchad.configs.lspconfig").defaults()
		require("configs.lspconfig")
	end,
}, {
	"williamboman/mason.nvim",
	opts = {
		ensure_installed = {
			"clangd", "stylua", "clang-format", "pyright"
		},
	},
}, {
	"nvim-treesitter/nvim-treesitter",
	opts = {
		ensure_installed = {
			"vim", "lua", "vimdoc", "cpp", "c", "glsl", "python"
		},
		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_filesize = 128 * 1024 -- 128 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		}
	},
}, {
	"hrsh7th/nvim-cmp",
	opts = function()
		local conf = require("nvchad.configs.cmp")

		conf.window.completion = require("cmp").config.window.bordered();
		conf.window.documentation = require("cmp").config.window.bordered();

		conf.mapping['<C-g>'] = function()
			if require("cmp").visible_docs() then
				require("cmp").close_docs()
			else
				require("cmp").open_docs()
			end
		end

		return conf
	end,
}, {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = false,
	opts = {},
}, {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
  end
}, {
  'mrcjkb/rustaceanvim',
  version = '^7', -- Recommended
  lazy = false, -- This plugin is already lazy
}
}
