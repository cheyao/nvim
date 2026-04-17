return {
    "nvim-lua/plenary.nvim",
    {
        lazy = false,
        "nvchad/base46",
        build = function()
            require("base46").load_all_highlights()
        end,
    }, {
    "nvchad/ui",
    lazy = false,
    config = function()
        require "nvchad"
    end,
},
    "nvzone/volt",
    "nvzone/menu",
    { "nvzone/minty", cmd = { "Huefy", "Shades" } },
    {
        "nvim-tree/nvim-web-devicons",
        opts = function()
            dofile(vim.g.base46_cache .. "devicons")
            return { override = require "nvchad.icons.devicons" }
        end,
    }, {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
        indent = { char = "│", highlight = "IblChar" },
        scope = { char = "│", highlight = "IblScopeChar" },
    },
    config = function(_, opts)
        dofile(vim.g.base46_cache .. "blankline")

        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
        require("ibl").setup(opts)

        dofile(vim.g.base46_cache .. "blankline")
    end,
}, {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = function()
        return require "nvchad.configs.nvimtree"
    end,
}, {
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = function()
        dofile(vim.g.base46_cache .. "whichkey")
        return {}
    end,
}, {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = { lua = { "stylua" } },
    },
}, {
    "lewis6991/gitsigns.nvim",
    event = "User FilePost",
    opts = function()
        return require "nvchad.configs.gitsigns"
    end,
}, {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function()
        return require "nvchad.configs.mason"
    end,
}, {
    "neovim/nvim-lspconfig",
    event = "User FilePost",
    config = function()
        require("nvchad.configs.lspconfig").defaults()
    end,
}, {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        {
            -- snippet plugin
            "L3MON4D3/LuaSnip",
            dependencies = "rafamadriz/friendly-snippets",
            opts = { history = true, updateevents = "TextChanged,TextChangedI" },
            config = function(_, opts)
                require("luasnip").config.set_config(opts)
                require "nvchad.configs.luasnip"
            end,
        },

        -- autopairing of (){}[] etc
        {
            "windwp/nvim-autopairs",
            opts = {
                fast_wrap = {},
                disable_filetype = { "TelescopePrompt", "vim" },
            },
            config = function(_, opts)
                require("nvim-autopairs").setup(opts)

                -- setup cmp for autopairs
                local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end,
        },

        -- cmp sources plugins
        {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "https://codeberg.org/FelipeLema/cmp-async-path.git",
        },
    },
    opts = function()
        return require "nvchad.configs.cmp"
    end,
}, {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "Telescope",
    opts = function()
        return require "nvchad.configs.telescope"
    end,
}, {
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
            "clangd", "stylua", "clang-format"
        },
    },
}, {
    "romus204/tree-sitter-manager.nvim",
    dependencies = {},
    lazy = false,
    config = function()
        require("tree-sitter-manager").setup({
            ensure_installed = { "python", "c", "cpp", "rust", "systemverilog", "lua" },
            border = nil,
            auto_install = true,
        })
    end
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
    'mrcjkb/rustaceanvim',
    version = '^7', -- Recommended
    lazy = false,   -- This plugin is already lazy
}, {
    -- Setup happens in configs/server-settings/clangd.lua
    "p00f/clangd_extensions.nvim",
    lazy = true,
}
}
