local M = {}

M.mappings = {
  mappings = {
    issue = {
      close_issue = { lhs = '<localleader>oic', desc = 'close issue' },
      reopen_issue = { lhs = '<localleader>oio', desc = 'reopen issue' },
      list_issues = { lhs = '<localleader>oil', desc = 'list open issues on same repo' },
      reload = { lhs = '<C-r>', desc = 'reload issue' },
      open_in_browser = { lhs = '<C-b>', desc = 'open issue in browser' },
      copy_url = { lhs = '<C-y>', desc = 'copy url to system clipboard' },
      add_assignee = { lhs = '<localleader>oaa', desc = 'add assignee' },
      remove_assignee = { lhs = '<localleader>oad', desc = 'remove assignee' },
      create_label = { lhs = '<localleader>olc', desc = 'create label' },
      add_label = { lhs = '<localleader>ola', desc = 'add label' },
      remove_label = { lhs = '<localleader>old', desc = 'remove label' },
      goto_issue = { lhs = '<localleader>ogi', desc = 'navigate to a local repo issue' },
      add_comment = { lhs = '<localleader>oca', desc = 'add comment' },
      delete_comment = { lhs = '<localleader>ocd', desc = 'delete comment' },
      next_comment = { lhs = ']c', desc = 'go to next comment' },
      prev_comment = { lhs = '[c', desc = 'go to previous comment' },
      react_hooray = { lhs = '<localleader>orp', desc = 'add/remove 🎉 reaction' },
      react_heart = { lhs = '<localleader>orh', desc = 'add/remove ❤️ reaction' },
      react_eyes = { lhs = '<localleader>ore', desc = 'add/remove 👀 reaction' },
      react_thumbs_up = { lhs = '<localleader>or+', desc = 'add/remove 👍 reaction' },
      react_thumbs_down = { lhs = '<localleader>or-', desc = 'add/remove 👎 reaction' },
      react_rocket = { lhs = '<localleader>orr', desc = 'add/remove 🚀 reaction' },
      react_laugh = { lhs = '<localleader>orl', desc = 'add/remove 😄 reaction' },
      react_confused = { lhs = '<localleader>orc', desc = 'add/remove 😕 reaction' },
    },
    pull_request = {
      checkout_pr = { lhs = '<localleader>opo', desc = 'checkout PR' },
      merge_pr = { lhs = '<localleader>opm', desc = 'merge commit PR' },
      squash_and_merge_pr = { lhs = '<localleader>opsm', desc = 'squash and merge PR' },
      list_commits = { lhs = '<localleader>opc', desc = 'list PR commits' },
      list_changed_files = { lhs = '<localleader>opf', desc = 'list PR changed files' },
      show_pr_diff = { lhs = '<localleader>opd', desc = 'show PR diff' },
      add_reviewer = { lhs = '<localleader>ova', desc = 'add reviewer' },
      remove_reviewer = { lhs = '<localleader>ovd', desc = 'remove reviewer request' },
      close_issue = { lhs = '<localleader>oic', desc = 'close PR' },
      reopen_issue = { lhs = '<localleader>oio', desc = 'reopen PR' },
      list_issues = { lhs = '<localleader>oil', desc = 'list open issues on same repo' },
      reload = { lhs = '<C-r>', desc = 'reload PR' },
      open_in_browser = { lhs = '<C-b>', desc = 'open PR in browser' },
      copy_url = { lhs = '<C-y>', desc = 'copy url to system clipboard' },
      goto_file = { lhs = 'gf', desc = 'go to file' },
      add_assignee = { lhs = '<localleader>oaa', desc = 'add assignee' },
      remove_assignee = { lhs = '<localleader>oad', desc = 'remove assignee' },
      create_label = { lhs = '<localleader>olc', desc = 'create label' },
      add_label = { lhs = '<localleader>ola', desc = 'add label' },
      remove_label = { lhs = '<localleader>old', desc = 'remove label' },
      goto_issue = { lhs = '<localleader>ogi', desc = 'navigate to a local repo issue' },
      add_comment = { lhs = '<localleader>oca', desc = 'add comment' },
      delete_comment = { lhs = '<localleader>ocd', desc = 'delete comment' },
      next_comment = { lhs = ']c', desc = 'go to next comment' },
      prev_comment = { lhs = '[c', desc = 'go to previous comment' },
      react_hooray = { lhs = '<localleader>orp', desc = 'add/remove 🎉 reaction' },
      react_heart = { lhs = '<localleader>orh', desc = 'add/remove ❤️ reaction' },
      react_eyes = { lhs = '<localleader>ore', desc = 'add/remove 👀 reaction' },
      react_thumbs_up = { lhs = '<localleader>or+', desc = 'add/remove 👍 reaction' },
      react_thumbs_down = { lhs = '<localleader>or-', desc = 'add/remove 👎 reaction' },
      react_rocket = { lhs = '<localleader>orr', desc = 'add/remove 🚀 reaction' },
      react_laugh = { lhs = '<localleader>orl', desc = 'add/remove 😄 reaction' },
      react_confused = { lhs = '<localleader>orc', desc = 'add/remove 😕 reaction' },
    },
    review_thread = {
      goto_issue = { lhs = '<localleader>ogi', desc = 'navigate to a local repo issue' },
      add_comment = { lhs = '<localleader>oca', desc = 'add comment' },
      add_suggestion = { lhs = '<localleader>osa', desc = 'add suggestion' },
      delete_comment = { lhs = '<localleader>ocd', desc = 'delete comment' },
      next_comment = { lhs = ']c', desc = 'go to next comment' },
      prev_comment = { lhs = '[c', desc = 'go to previous comment' },
      select_next_entry = { lhs = ']q', desc = 'move to previous changed file' },
      select_prev_entry = { lhs = '[q', desc = 'move to next changed file' },
      close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
      react_hooray = { lhs = '<localleader>orp', desc = 'add/remove 🎉 reaction' },
      react_heart = { lhs = '<localleader>orh', desc = 'add/remove ❤️ reaction' },
      react_eyes = { lhs = '<localleader>ore', desc = 'add/remove 👀 reaction' },
      react_thumbs_up = { lhs = '<localleader>or+', desc = 'add/remove 👍 reaction' },
      react_thumbs_down = { lhs = '<localleader>or-', desc = 'add/remove 👎 reaction' },
      react_rocket = { lhs = '<localleader>orr', desc = 'add/remove 🚀 reaction' },
      react_laugh = { lhs = '<localleader>orl', desc = 'add/remove 😄 reaction' },
      react_confused = { lhs = '<localleader>orc', desc = 'add/remove 😕 reaction' },
    },
    submit_win = {
      approve_review = { lhs = '<C-a>', desc = 'approve review' },
      comment_review = { lhs = '<C-m>', desc = 'comment review' },
      request_changes = { lhs = '<C-r>', desc = 'request changes review' },
      close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
    },
    review_diff = {
      add_review_comment = { lhs = '<localleader>oca', desc = 'add a new review comment' },
      add_review_suggestion = { lhs = '<localleader>osa', desc = 'add a new review suggestion' },
      focus_files = { lhs = '<leader>e', desc = 'move focus to changed file panel' },
      toggle_files = { lhs = '<leader>b', desc = 'hide/show changed files panel' },
      next_thread = { lhs = ']t', desc = 'move to next thread' },
      prev_thread = { lhs = '[t', desc = 'move to previous thread' },
      select_next_entry = { lhs = ']q', desc = 'move to previous changed file' },
      select_prev_entry = { lhs = '[q', desc = 'move to next changed file' },
      close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
      -- toggle_viewed = { lhs = "<leader><localleader>o", desc = "toggle viewer viewed state" },
      goto_file = { lhs = 'gf', desc = 'go to file' },
    },
    file_panel = {
      next_entry = { lhs = 'j', desc = 'move to next changed file' },
      prev_entry = { lhs = 'k', desc = 'move to previous changed file' },
      select_entry = { lhs = '<cr>', desc = 'show selected changed file diffs' },
      refresh_files = { lhs = 'R', desc = 'refresh changed files panel' },
      focus_files = { lhs = '<leader>e', desc = 'move focus to changed file panel' },
      toggle_files = { lhs = '<leader>b', desc = 'hide/show changed files panel' },
      select_next_entry = { lhs = ']q', desc = 'move to previous changed file' },
      select_prev_entry = { lhs = '[q', desc = 'move to next changed file' },
      close_review_tab = { lhs = '<C-c>', desc = 'close review tab' },
      -- toggle_viewed = { lhs = "<leader><localleader>o", desc = "toggle viewer viewed state" },
    },
  },
}

return {
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    config = true,
  },
  {
    'NeogitOrg/neogit',
    lazy = false,
    priority = 1000,
    event = 'VeryLazy',
    cmd = 'Neogit',
    opts = {
      integrations = { diffview = true, telescope = true },
      disable_commit_confirmation = true,
      -- kind = "vsplit",
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    lazy = true,
    priority = 1000,
    opts = {
      numhl = true,
      signs = {
        add = { hl = 'GitSignsAdd', text = '▍', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change = {
          hl = 'GitSignsChange',
          text = '▍',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
        delete = {
          hl = 'GitSignsDelete',
          text = '▸',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        topdelete = {
          hl = 'GitSignsDelete',
          text = '▾',
          numhl = 'GitSignsDeleteNr',
          linehl = 'GitSignsDeleteLn',
        },
        changedelete = {
          hl = 'GitSignsChange',
          text = '▍',
          numhl = 'GitSignsChangeNr',
          linehl = 'GitSignsChangeLn',
        },
      },
      -- update_debounce = 100,
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        -- map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
        -- map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
        -- map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
        -- map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        -- map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
        -- map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
        -- map("n", "<leader>ghb", function()
        --   gs.blame_line { full = true }
        -- end, { desc = "Blame Line" })
        -- map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
        -- map("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
        -- map("n", "<leader>ghD", function()
        --   gs.diffthis "~"
        -- end, { desc = "Diff This ~" })
        -- map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle Delete" })

        -- -- Text object
        -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
        --

        local wk = require 'which-key'
        wk.register({
          g = { '<Cmd>Neogit<Cr>', 'NeoGit' },
          h = { '<Cmd>GlLog<cr>', 'File history' },
        }, { prefix = '<localleader>' })

        wk.register({
          g = {
            name = 'Git',
            a = { '<Cmd>Telescope repo list<Cr>', 'All repositories' },
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev Hunk' },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
            l = { "<cmd>lua require('gitsigns').blame_line()<CR>", 'Blame' },
            o = { ':Octo actions<cr>', 'Octor actions' },
            v = { '<Cmd>DiffviewOpen<Cr>', 'Diffview open' },
            c = { '<Cmd>DiffviewClose<Cr>', 'Diffview close' },
            y = {
              "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
              'Link',
            },
            t = { "<cmd>lua require('telescope').extensions.advanced_git_search.show_custom_functions()<cr>", 'Telescope' },

            w = {
              name = 'Worktree',
              c = {
                "<cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree(require('telescope.themes').get_ivy({}))<cr>",
                'Create',
              },
              w = {
                "<cmd>:lua require('telescope').extensions.git_worktree.git_worktrees(require('telescope.themes').get_ivy({}))<cr>",
                'Worktrees',
              },
            },
          },
        }, { prefix = '<leader>' })
      end,
    },
  },
  {
    'aaronhallaert/advanced-git-search.nvim',
    config = function()
      require('telescope').load_extension 'advanced_git_search'
    end,
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tpope/vim-fugitive',
    },
  },
  -- {
  --   "pwntester/octo.nvim",
  --   lazy = true,
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   config = function()
  --     require("octo").setup {
  --       require("plugins.git").mappings,
  --     }
  --   end,
  -- },

  {
    'akinsho/git-conflict.nvim',
    config = function()
      require('git-conflict').setup()
    end,
  },
  'AndrewRadev/diffurcate.vim', -- see fish
  {
    'ThePrimeagen/git-worktree.nvim',
    config = function()
      require('git-worktree').setup()
    end,
  },
  {
    'ruifm/gitlinker.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    module = 'gitlinker',
    config = function()
      require('gitlinker').setup { mappings = nil }
    end,
  },
}
