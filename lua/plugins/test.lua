return {
  {
    "vim-test/vim-test",
    -- keys = {
    --   { "<leader>tc", "<cmd>w|TestClass<cr>", desc = "Class" },
    --   { "<leader>tf", "<cmd>w|TestFile<cr>", desc = "File" },
    --   { "<leader>tl", "<cmd>w|TestLast<cr>", desc = "Last" },
    --   { "<leader>tn", "<cmd>w|TestNearest<cr>", desc = "Nearest" },
    --   { "<leader>ts", "<cmd>w|TestSuite<cr>", desc = "Suite" },
    --   { "<leader>tv", "<cmd>w|TestVisit<cr>", desc = "Visit" },
    -- },
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "belowright"
      vim.g["test#neovim#preserve_screen"] = 1
      vim.g["test#python#runner"] = "pyunit" -- pytest
    end,
  },
  {
    "nvim-neotest/neotest",
    lazy = false,
    keys = {
      { "<leader>nF", "<cmd>w|lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", desc = "Debug File" },
      { "<leader>nL", "<cmd>w|lua require('neotest').run.run_last({strategy = 'dap'})<cr>", desc = "Debug Last" },
      { "<leader>na", "<cmd>w|lua require('neotest').run.attach()<cr>", desc = "Attach" },
      { "<leader>nf", "<cmd>w|lua require('neotest').run.run(vim.fn.expand('%'))<cr>", desc = "File" },
      { "<leader>nl", "<cmd>w|lua require('neotest').run.run_last()<cr>", desc = "Last" },
      { "<leader>nn", "<cmd>w|lua require('neotest').run.run()<cr>", desc = "Nearest" },
      { "<leader>nN", "<cmd>w|lua require('neotest').run.run({strategy = 'dap'})<cr>", desc = "Debug Nearest" },
      { "<leader>no", "<cmd>w|lua require('neotest').output.open({ enter = true })<cr>", desc = "Output" },
      { "<leader>ns", "<cmd>w|lua require('neotest').run.stop()<cr>", desc = "Stop" },
      { "<leader>nS", "<cmd>w|lua require('neotest').summary.toggle()<cr>", desc = "Summary" },
    },
    dependencies = {
      "vim-test/vim-test",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-plenary",
      "nvim-neotest/neotest-vim-test",
      "jfpedroza/neotest-elixir",
      "rouge8/neotest-rust",
      "hiphish/neotest-busted",
    },
    config = function()
      local opts = {
        adapters = {
          -- require "neotest-elixir",
          require "neotest-elixir" {
            -- The Mix task to use to run the tests
            -- Can be a function to return a dynamic value.
            -- Default: "test"
            -- mix_task = { "test.interactive" },
          },
          require "neotest-python" {
            dap = { justMyCode = false },
            runner = "unittest",
          },
          require "neotest-plenary",
          require "neotest-vim-test" {
            ignore_file_types = { "python", "vim", "lua" },
          },
          require "neotest-rust",
          require "neotest-busted",
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            if require("utils").has "trouble.nvim" then
              vim.cmd "Trouble quickfix"
            else
              vim.cmd "copen"
            end
          end,
        },
        -- overseer.nvim
        consumers = {
          overseer = require "neotest.consumers.overseer",
        },
        overseer = {
          enabled = true,
          force_default = true,
        },
      }
      require("neotest").setup(opts)
    end,
  },
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>oR", "<cmd>OverseerRunCmd<cr>", desc = "Run Command" },
      { "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Task Action" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Build" },
      { "<leader>oc", "<cmd>OverseerClose<cr>", desc = "Close" },
      { "<leader>od", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete Bundle" },
      { "<leader>ol", "<cmd>OverseerLoadBundle<cr>", desc = "Load Bundle" },
      { "<leader>oo", "<cmd>OverseerOpen<cr>", desc = "Open" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run" },
      { "<leader>os", "<cmd>OverseerSaveBundle<cr>", desc = "Save Bundle" },
      { "<leader>ot", "<cmd>OverseerToggle<cr>", desc = "Toggle" },
    },
    config = true,
  },
}
