local M = {}

function M.setup()
  local wk = require 'which-key'
  wk.register({
    t = {
      name = 'Notes',
      n = { "<cmd>lua require('nabla').popup()<CR>", 'Notation' },
    },
  }, { prefix = '<leader>' })
end

return {
  { 'lukas-reineke/headlines.nvim', config = true, ft = { 'markdown', 'org', 'norg' } },
  {
    'jbyuki/nabla.nvim',
    config = function()
      require('nabla').enable_virt()
      M.setup()
    end,
  },
  { 'mzlogin/vim-markdown-toc', ft = { 'markdown' } },
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = '~/Repositories/Corpus',
        },
      },
    },
  },
}
