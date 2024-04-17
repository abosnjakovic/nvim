return {
  "nvim-lua/plenary.nvim",
  "MunifTanjim/nui.nvim",
  { "lambdalisue/suda.vim", lazy = true, event = "VeryLazy" },
  {
    "numToStr/Navigator.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      ---@diagnostic disable-next-line: missing-parameter
      require("Navigator").setup()
      vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
      vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
      vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
      vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
      vim.keymap.set({ "n", "t" }, "<C-p>", "<CMD>NavigatorPrevious<CR>")
    end,
  },
  {
    "ThePrimeagen/vim-apm",
    lazy = true,
    event = "VeryLazy",
    priority = 1000,
    config = function()
      local apm = require "vim-apm"

      apm:setup {}
      vim.keymap.set("n", "<leader>cp", function()
        apm:toggle_monitor()
      end)
    end,
  },
  {
    "echasnovski/mini.files",
    version = false,
    lazy = false,
    config = function()
      require("mini.files").setup {
        windows = {
          preview = true,
          width_preview = 80,
        },
        mappings = {
          synchronize = "<C-s>",
        },
      }
    end,
  },
}
