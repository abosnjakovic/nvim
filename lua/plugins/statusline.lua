local icons = require 'config.icons'
local Job = require 'plenary.job'

local function fg(name)
  return function()
    local hl = vim.api.nvim_get_hl_by_name(name, true)
    return hl and hl.foreground and { fg = string.format('#%06x', hl.foreground) }
  end
end

local components = {
  spaces = {
    function()
      local shiftwidth = vim.api.nvim_buf_get_option(0, 'shiftwidth')
      return icons.ui.Tab .. ' ' .. shiftwidth
    end,
    padding = 1,
  },
  git_repo = {
    function()
      local results = {}
      local job = Job:new {
        command = 'git',
        args = { 'rev-parse', '--show-toplevel' },
        cwd = vim.fn.expand '%:p:h',
        on_stdout = function(_, line)
          table.insert(results, line)
        end,
      }
      job:sync()
      if results[1] ~= nil then
        return vim.fn.fnamemodify(results[1], ':t')
      else
        return ''
      end
    end,
  },
  separator = {
    function()
      return '%='
    end,
  },
  diff = {
    'diff',
    source = function()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end,
  },
  diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    diagnostics_color = {
      error = 'DiagnosticError',
      warn = 'DiagnosticWarn',
      info = 'DiagnosticInfo',
      hint = 'DiagnosticHint',
    },
    colored = true,
  },
  lsp_client = {
    function(msg)
      msg = msg or ''
      local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }

      if next(buf_clients) == nil then
        if type(msg) == 'boolean' or #msg == 0 then
          return ''
        end
        return msg
      end

      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client TODO null-ls add statusline
      for _, client in pairs(buf_clients) do
        table.insert(buf_client_names, client.name)
      end

      local hash = {}
      local client_names = {}
      for _, v in ipairs(buf_client_names) do
        if not hash[v] then
          client_names[#client_names + 1] = v
          hash[v] = true
        end
      end
      table.sort(client_names)
      return table.concat(client_names, ', ')
    end,
    -- icon = icons.ui.Code,
    colored = true,
    on_click = function()
      vim.cmd [[LspInfo]]
    end,
  },
  noice_mode = {
    function()
      return require('noice').api.status.mode.get()
    end,
    cond = function()
      return package.loaded['noice'] and require('noice').api.status.mode.has()
    end,
    color = fg 'Constant',
  },
  noice_command = {
    function()
      return require('noice').api.status.command.get()
    end,
    cond = function()
      return package.loaded['noice'] and require('noice').api.status.command.has()
    end,
    color = fg 'Statement',
  },
}

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'meuter/lualine-so-fancy.nvim',
    },
    event = 'VeryLazy',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = {},
          section_separators = {},
          disabled_filetypes = {
            statusline = { 'lazy', 'fugitive', '', 'NeogitCommitMessage', 'noice' },
            winbar = {
              'help',
              'lazy',
              'NeogitCommitMessage',
              'noice',
            },
          },
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { { 'fancy_mode', width = 3 } },
          lualine_b = { components.git_repo, 'branch' },
          lualine_c = {
            { 'fancy_cwd', substitute_home = true },
            components.diff,
            { 'fancy_diagnostics' },
            components.noice_command,
            components.noice_mode,
            -- { require("NeoComposer.ui").status_recording },
            components.separator,
            components.lsp_client,
          },
          lualine_x = { 'filename', components.spaces, 'encoding', 'fileformat', 'filetype', 'progress' },
          lualine_y = {},
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        extensions = { 'nvim-tree', 'quickfix' },
      }
    end,
  },
}
