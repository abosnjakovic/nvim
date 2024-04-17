return {
  {
    "mrjones2014/legendary.nvim",
    keys = {
      { "<M-p>", "<cmd>Legendary<cr>", desc = "Legendary" },
    },
    opts = {
      which_key = { auto_register = true },
    },
  },
  {
    "folke/which-key.nvim",
    dependencies = {
      "mrjones2014/legendary.nvim",
    },
    event = "VeryLazy",
    opts = {
      setup = {
        -- ignore_missing = true,
        key_labels = { ["<leader>"] = "SPC" },
        triggers = "auto",
        window = {
          border = "none", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 1, 1, 1, 1 }, -- extra window padding [top, right, bottom, left]
          winblend = 40,
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
          align = "center", -- align columns left, center or right
        },
      },
      defaults = {
        prefix = "<leader>",
        mode = { "n", "v" },
        -- stylua: ignore
        q = { function() require("utils").quit() end, "which_key_ignore", },

        ["<space>"] = { "<cmd>lua require('telescope.builtin').commands(require('telescope.themes').get_ivy({}))<CR>", "which_key_ignore" },

        [","] = {
          "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args(require('telescope.themes').get_ivy())<cr>",
          "which_key_ignore",
        },
        ["."] = {
          "<Cmd>lua require('telescope').extensions.smart_open.smart_open(require('telescope.themes').get_ivy({cwd_only = true}))<CR>",
          "which_key_ignore",
        },
        -- e = {
        --   "<cmd>lua require'telescope'.extensions.file_browser.file_browser( require('telescope.themes').get_ivy({path='%:p:h', cwd_to_path = true, theme = ivy, hidden = true}))<cr><esc>",
        --   "which_key_ignore",
        -- },
        a = { "<cmd>AerialToggle<cr>", "which_key_ignore" },
        e = { "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0), true)<cr>", "which_key_ignore" },
        m = {
          "<cmd>lua require('telescope.builtin').marks(require('telescope.themes').get_ivy({}))<cr>",
          "which_key_ignore",
        },
        [";"] = {
          "<cmd>lua require('telescope.builtin').resume(require('telescope.themes').get_ivy({}))<cr>",
          "which_key_ignore",
        },
        ["/"] = {
          "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy({}))<cr>",
          "which_key_ignore",
        },
        k = {
          "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({}))<cr>",
          "which_key_ignore",
        },
        h = { "<Cmd>lua require('telescope.builtin').help_tags(require('telescope.themes').get_ivy({}))<Cr>", "which_key_ignore" },
        u = { "<cmd>UndotreeToggle<cr>", "which_key_ignore" },
        z = { "<cmd>ZenMode<cr>", "which_key_ignore" },

        -- z = { "<cmd>ZenMode<cr>", "which_key_ignore" },

        --         keys = {
        --   { "<leader><space>",function() require('telescope.builtin').commands(require('telescope.themes').get_ivy({})) end },
        --   { "<leader>ff", require("utils").find_files, desc = "Find Files" },
        -- },

        d = { name = "+Debug" },
        b = { name = "+Database" },
        r = { name = "+Refactor" },
        -- t = { name = "+Test", o = { "Overseer" } },
        n = { name = "+Neotest" },
        o = { name = "+Overseer" },
        c = {
          -- c = { "<cmd>lua vim.cmd [[call setqflist([])]]<cr>", "Clear Quickfix" },
          name = "+Code",
          g = { name = "Annotation" },
          x = {
            name = "Swap Next",
            f = "Function",
            p = "Parameter",
            c = "Class",
          },
          X = {
            name = "Swap Previous",
            f = "Function",
            p = "Parameter",
            c = "Class",
          },
        },
      },
    },
    config = function(_, opts)
      local wk = require "which-key"
      wk.setup(opts.setup)
      wk.register(opts.defaults)
    end,
  },
}
