return {
  {
    'chrisgrieser/nvim-chainsaw',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require('chainsaw').setup {
        logStatements = {
          variableLog = {
            elixir = 'IO.inspect("%s %s #{%s}")',
          },
          -- the same way for the other statement types
        },
      }
    end,
  },

  {
    'mfussenegger/nvim-lint',
    lazy = true,
    event = 'VeryLazy',
    config = function()
      require('lint').linters_by_ft = {
        markdown = { 'vale' },
        yaml = { 'yamllint' },
        sh = { 'shellcheck' },
        -- rust = { "cargo clippy" },
        -- go = { "golangci_lint" },
        cpp = { 'clangtidy' },
        c = { 'clangtidy' },
        awk = { 'awk' },
        -- lua = { "luacheck" },
        dockerfile = { 'hadolint' },
        sql = { 'sqlfluff' },
        toml = { 'toml' },
        json = { 'jsonlint' },
        html = { 'htmlhint' },
        css = { 'stylelint' },
        scss = { 'stylelint' },
        javascript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescript = { 'eslint' },
        typescriptreact = { 'eslint' },
        elixir = { 'credo' },
        trivy = { 'trivy' },
        zsh = { 'zsh' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          require('lint').try_lint()
        end,
      })
    end,
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {},
    config = function()
      require('conform').setup {
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'isort', 'black' },
          javascript = { { 'prettierd', 'prettier' } },
          typescript = { { 'prettierd', 'prettier' } },
          css = { { 'prettierd', 'prettier' } },
          json = { { 'prettierd', 'prettier' } },
          scss = { { 'prettierd', 'prettier' } },
          html = { { 'prettierd', 'prettier' } },
          elixir = { 'mix format' },
          sql = { 'sqlformat' },
          rust = { 'rustfmt' },
          go = { 'gofmt' },
          toml = { 'tomlformat' },
          yaml = { 'prettierd' },
          sh = { 'shfmt' },
          cpp = { 'clangformat' },
          c = { 'clangformat' },
          awk = { 'awkformat' },
        },
      }
    end,
  },

  {
    'amrbashir/nvim-docs-view',
    opt = true,
    cmd = { 'DocsViewToggle' },
    config = function()
      require('docs-view').setup {
        position = 'left',
        width = 80,
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      {
        'folke/neodev.nvim',
        opts = {
          library = { plugins = { 'neotest', 'nvim-dap-ui' }, types = true },
        },
      },
      { 'j-hui/fidget.nvim', config = true, tag = 'legacy' },
      { 'smjonas/inc-rename.nvim', config = true },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    opts = {
      inlay_hints = { enabled = true },
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = { callSnippet = 'Both', workspaceWord = true },
              telemetry = { enable = false },
              hint = {
                enable = true,
                arrayIndex = 'Disable', -- "Enable" | "Disable" | "Auto"
                setType = true,
                paramType = true,
                paramName = true,
                paramDoc = true,
                await = true,
              },
              groupFileStatus = {
                ['ambiguity'] = 'Opened',
                ['await'] = 'Opened',
                ['codestyle'] = 'None',
                ['duplicate'] = 'Opened',
                ['global'] = 'Opened',
                ['luadoc'] = 'Opened',
                ['redefined'] = 'Opened',
                ['strict'] = 'Opened',
                ['strong'] = 'Opened',
                ['type-check'] = 'Opened',
                ['unbalanced'] = 'Opened',
                ['unused'] = 'Opened',
              },
              unusedLocalExclude = { '_*' },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = '2',
                  continuation_indent_size = '2',
                },
              },
            },
          },
        },
        dockerls = {},
        mojo = {},
      },
      setup = {
        lua_ls = function(_, _)
          local lsp_utils = require 'plugins.lsp.utils'
          lsp_utils.on_attach(function(client, buffer)
            -- stylua: ignore
            if client.name == "lua_ls" then
              vim.keymap.set("n", "<leader>cR", function() require("osv").run_this() end,
                { buffer = buffer, desc = "OSV Run" })
              vim.keymap.set("n", "<leader>cL", function() require("osv").launch({ port = 8086 }) end,
                { buffer = buffer, desc = "OSV Launch" })
            end
          end)
        end,
      },
      format = {
        timeout_ms = 3000,
      },
    },
    config = function(plugin, opts)
      require('plugins.lsp.servers').setup(plugin, opts)
    end,
  },
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = 'Mason',
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = { use_diagnostic_signs = true },
  },
  -- vscode like drop bar with outline context, i think its useless
  -- {
  --   'Bekaboo/dropbar.nvim',
  --   event = 'VeryLazy',
  --   enabled = true,
  --   opts = {
  --     general = {
  --       enable = function(buf, win)
  --         return not vim.bo.filetype ~= 'NeogitCommitMessage'
  --           and vim.api.nvim_win_get_config(win).zindex
  --           and vim.bo[buf].buftype == ''
  --           and vim.api.nvim_buf_get_name(buf) ~= ''
  --           and not vim.wo[win].diff
  --       end,
  --     },
  --   },
  -- },
}
