local swap_next, swap_prev = (function()
  local swap_objects = {
    p = '@parameter.inner',
    f = '@function.outer',
    c = '@class.outer',
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format('<leader>cx%s', key)] = obj
    p[string.format('<leader>cX%s', key)] = obj
  end

  return n, p
end)()

return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'RRethy/nvim-treesitter-endwise',
      'windwp/nvim-ts-autotag',
      'nvim-treesitter/playground',
      'nvim-treesitter/nvim-treesitter-context',
    },
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      sync_install = false,
      ensure_installed = {
        'bash',
        -- "dapl_repl",
        'dockerfile',
        'html',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'org',
        'query',
        'regex',
        'latex',
        'vim',
        'vimdoc',
        'yaml',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org', 'markdown' },
        disable = { 'NeogitCommitMessage' },
      },
      indent = { enable = true },
      -- context_commentstring = { enable = true, enable_autocmd = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = swap_next,
          swap_previous = swap_prev,
        },
      },
      matchup = {
        enable = true,
      },
      endwise = {
        enable = true,
      },
      autotag = {
        enable = true,
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)
      require('treesitter-context').setup {}
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      local npairs = require 'nvim-autopairs'
      npairs.setup {
        check_ts = true,
      }
    end,
  },

  {
    'Wansmer/treesj',
    cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup {
        use_default_keymaps = false,
      }
    end,
  },

  { 'echasnovski/mini.hipatterns', version = '*' },
}
