return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "dockerfile" })
      end
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {},
      },
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      {
        "lpoto/telescope-docker.nvim",
        opts = {},
        config = function(_, opts)
          require("telescope").load_extension "docker"
        end,
        keys = {
          { "<leader>cd", "<Cmd>Telescope docker<CR>", desc = "Docker" },
        },
      },
    },
  },
}
