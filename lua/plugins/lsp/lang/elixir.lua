return {
  {
    "elixir-tools/elixir-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require "elixir"
      local elixirls = require "elixir.elixirls"

      elixir.setup {
        nextls = {
          enable = false,
          cmd = "/home/linuxbrew/.linuxbrew/bin/nextls",
          init_options = {
            experimental = {
              completions = {
                enable = false, -- control if completions are enabled. defaults to false
              },
            },
          },
          -- cmd = "path/to/next-ls"
        },
        credo = { enabled = true },
        elixirls = {
          enable = true,
          -- cmd = "/home/linuxbrew/.linuxbrew/bin/elixir-ls",
          settings = elixirls.settings {
            dialyzerEnabled = true,
            enableTestLenses = true,
            suggestSpecs = true,
            fetchDeps = false,
          },
        },
      }

      -- NOTE: lexical ls is experimental and may be added to elixir-tools
      -- https://github.com/lexical-lsp/lexical/blob/main/pages/installation.md#neovim

      -- local lspconfig = require "lspconfig"
      -- local configs = require "lspconfig.configs"

      -- local lexical_config = {
      --   filetypes = { "elixir", "eelixir", "heex" },
      --   cmd = { "/home/adam/Repositories/lexical/bin/start_lexical.sh" },
      --   settings = {},
      -- }

      -- if not configs.lexical then
      --   configs.lexical = {
      --     default_config = {
      --       filetypes = lexical_config.filetypes,
      --       cmd = lexical_config.cmd,
      --       root_dir = function(fname)
      --         return lspconfig.util.root_pattern("mix.exs", ".git")(fname) or vim.loop.os_homedir()
      --       end,
      --       -- optional settings
      --       settings = lexical_config.settings,
      --     },
      --   }
      -- end

      -- lspconfig.lexical.setup {}
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "elixir",
        "heex",
        "eex",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- elixirls = {},
      },
    },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "jfpedroza/neotest-elixir",
    },
    opts = {
      adapters = {
        ["neotest-elixir"] = {},
      },
    },
  },
}
