local M = {}

function M.telescope()
  local lga_actions = require "telescope-live-grep-args.actions"
  local telescope = require "telescope"
  local icons = require "config.icons"
  local actions = require "telescope.actions"
  local actions_layout = require "telescope.actions.layout"

  local function send_to_quickfix(promtbufnr)
    actions.smart_send_to_qflist(promtbufnr)
    vim.cmd [[topleft vert copen 60]]
  end

  local function add_to_quickfix(promtbufnr)
    actions.smart_add_to_qflist(promtbufnr)
    vim.cmd [[topleft vert copen 60]]
  end

  local function clear_qflist()
    vim.cmd [[call setqflist([])]]
  end

  local transform_mod = require("telescope.actions.mt").transform_mod
  local custom_actions = transform_mod {
    -- VisiData
    visidata = function(prompt_bufnr)
      -- Get the full path
      local content = require("telescope.actions.state").get_selected_entry()
      if content == nil then
        return
      end
      local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

      -- Close the Telescope window
      require("telescope.actions").close(prompt_bufnr)

      -- Open the file with VisiData
      local utils = require "utils"
      utils.open_term("vd " .. full_path, { direction = "float" })
    end,

    -- File browser
    file_browser = function(prompt_bufnr)
      local content = require("telescope.actions.state").get_selected_entry()
      if content == nil then
        return
      end

      local full_path = content.cwd
      if content.filename then
        full_path = content.filename
      elseif content.value then
        full_path = full_path .. require("plenary.path").path.sep .. content.value
      end

      -- Close the Telescope window
      require("telescope.actions").close(prompt_bufnr)

      -- Open file browser
      -- vim.cmd("Telescope file_browser select_buffer=true path=" .. vim.fs.dirname(full_path))
      -- require("telescope").extensions.file_browser.file_browser { select_buffer = true, path = vim.fs.dirname(full_path) }
    end,
  }

  local mappings = {
    i = {
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
      ["?"] = actions_layout.toggle_preview,
      ["<C-s>"] = custom_actions.visidata,
      ["<A-f>"] = custom_actions.file_browser,
      ["<C-q>"] = send_to_quickfix,
      ["<C-Q>"] = add_to_quickfix,
    },
    n = {
      ["s"] = custom_actions.visidata,
      ["<A-f>"] = custom_actions.file_browser,
      ["<C-q>"] = send_to_quickfix,
      ["<C-Q>"] = add_to_quickfix,
    },
  }

  local opts = {
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = icons.ui.Forward .. " ",
      mappings = mappings,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--ignore",
        "--hidden",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = false,
        hidden = true,
        find_command = { "rg", "--files", "--hidden", "-g", "!.git" },
      },
      git_files = {
        theme = "dropdown",
        previewer = false,
      },
      buffers = {
        theme = "dropdown",
        previewer = false,
      },
    },
    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        },
      },
      file_browser = {
        theme = "ivy",
        previewer = true,
        hijack_netrw = false,
        mappings = mappings,
      },
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        mappings = { -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
          },
        },
      },
      -- fzf = {
      --   fuzzy = true, -- false will only do exact matching
      --   override_generic_sorter = true, -- override the generic sorter
      --   override_file_sorter = true, -- override the file sorter
      --   case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      --   -- the default case_mode is "smart_case"
      -- },
    },
  }
  telescope.setup(opts)
  pcall(telescope.load_extension "fzf")
  -- telescope.load_extension "file_browser"
  -- telescope.load_extension "aerial"
  pcall(telescope.load_extension "dap")
  -- telescope.load_extension "frecency"
  pcall(telescope.load_extension "luasnip")
  pcall(telescope.load_extension "conventional_commits")
  pcall(telescope.load_extension "lazy")
  pcall(telescope.load_extension "noice")
  pcall(telescope.load_extension "live_grep_args")
  pcall(telescope.load_extension "smart_open")
  pcall(telescope.load_extension "ui-select")
  -- telescope.load_extension "macros"
end

-- return lazy
return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    event = "VeryLazy",
    lazy = false,
    priority = 1000,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-project.nvim",
      "ahmedkhalf/project.nvim",
      "cljoly/telescope-repo.nvim",
      "stevearc/aerial.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "kkharji/sqlite.lua",
      "aaronhallaert/advanced-git-search.nvim",
      "benfowler/telescope-luasnip.nvim",
      "olacin/telescope-cc.nvim",
      "tsakirist/telescope-lazy.nvim",
      "Marskey/telescope-sg",
      "nvim-telescope/telescope-live-grep-args.nvim", -- TODO  "telescope" -g **/plugins/*
      {
        "danielfalk/smart-open.nvim",
        dependencies = {
          "kkharji/sqlite.lua",
          -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
          { "nvim-telescope/telescope-fzy-native.nvim" },
        },
      },
      {
        "ecthelionvi/NeoComposer.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        enabled = false,
        opts = {},
      },
    },
    cmd = "Telescope",
    -- stylua: ignore
    config = function(_, _)
      M.telescope()
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup {
        layout = {
          min_width = 40,
          default_direction = "left",
        },
      }
    end,
  },
}
