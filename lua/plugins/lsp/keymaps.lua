local M = {}

function M.on_attach(client, buffer)
  local self = M.new(client, buffer)

  self:map('gd', 'Telescope lsp_definitions', { desc = 'Goto Definition' })
  self:map('gr', 'Telescope lsp_references', { desc = 'References' })
  self:map('gD', 'Lspsaga peek_definition', { desc = 'Peek Definition' })
  self:map('gI', 'Telescope lsp_implementations', { desc = 'Goto Implementation' })
  self:map('gb', 'Telescope lsp_type_definitions', { desc = 'Goto Type Definition' })
  -- self:map("K", "Lspsaga hover_doc", { desc = "Hover" })
  self:map('K', 'lua vim.lsp.buf.hover()', { desc = 'Hover' })
  self:map('gK', vim.lsp.buf.signature_help, { desc = 'Signature Help', has = 'signatureHelp' })
  self:map(']d', M.diagnostic_goto(true), { desc = 'Next Diagnostic' })
  self:map('[d', M.diagnostic_goto(false), { desc = 'Prev Diagnostic' })
  self:map(']e', M.diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
  self:map('[e', M.diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
  self:map(']w', M.diagnostic_goto(true, 'WARNING'), { desc = 'Next Warning' })
  self:map('[w', M.diagnostic_goto(false, 'WARNING'), { desc = 'Prev Warning' })

  -- Whichkey
  local wk = require 'which-key'
  wk.register({
    l = {
      name = 'LSP',
      p = { "<cmd>lua require('chainsaw').variableLog()<cr>", 'Print' },
      c = { '<cmd>Telescope luasnip<CR>', 'Snippets' },
      w = { "<cmd>lua require('plugins.lsp.utils').toggle_diagnostics()<CR>", 'Toggle inline' },
      N = { M.rename(), 'Rename' },
      F = { '<cmd>lua vim.lsp.buf.format { async = true }<cr>', 'Format' },
      R = { '<cmd>Trouble lsp_references<cr>', 'Trouble References' },
      -- a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
      a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Action' },
      d = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", 'Diagnostics' },
      f = { '<cmd>Lspsaga lsp_finder<CR>', 'Finder' },
      -- n = { "<cmd>lua require('renamer').rename()<CR>", "Rename" },
      r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", 'References' },
      s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", 'Document Symbols' },
      S = { "<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", 'Document Symbols' },
      t = { '<cmd>TroubleToggle document_diagnostics<CR>', 'Trouble' },
      L = { '<cmd>lua vim.lsp.codelens.refresh()<CR>', 'Refresh CodeLens' },
      l = { '<cmd>lua vim.lsp.codelens.run()<CR>', 'Run CodeLens' },
      D = { "<cmd>lua require('config.lsp').toggle_diagnostics()<CR>", 'Toggle Inline Diagnostics' },
      o = { '<Cmd>DocsViewToggle<CR>', 'Symbols Outline' },
      j = { '<cmd>:TSJToggle<CR>', 'Split Toggle' },
      x = { "<cmd>lua vim.lsp.stop_client(vim.lsp.get_active_clients()) vim.cmd('edit')<CR>", 'Restart LSP' },
    },
  }, { prefix = '<leader>' })
end

function M.new(client, buffer)
  return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
  return self.client.server_capabilities[cap .. 'Provider']
end

function M:map(lhs, rhs, opts)
  opts = opts or {}
  if opts.has and not self:has(opts.has) then
    return
  end
  vim.keymap.set(
    opts.mode or 'n',
    lhs,
    type(rhs) == 'string' and ('<cmd>%s<cr>'):format(rhs) or rhs,
    ---@diagnostic disable-next-line: no-unknown
    { silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
  )
end

function M.rename()
  if pcall(require, 'inc_rename') then
    return ':IncRename ' .. vim.fn.expand '<cword>'
  else
    vim.lsp.buf.rename()
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

return M
