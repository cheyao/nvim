return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require("configs.conform")
    end,
    opts = {
      formatters_by_ft = {
  	--	cpp = { "clang-format" },
  	--	c = { "clang-format" },
       }
    }
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
  			"clangd", "stylua", "clang-format"
  		},
  	},
  }, {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
  			"vim", "lua", "vimdoc", "cpp", "c", "glsl", "python"
  		},
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
  }
}
