local function augroup(name)
  return vim.api.nvim_create_augroup('neo' .. name, { clear = true })
end

-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup 'highlight_yank',
  pattern = '*',
})

-- show line diagnostics, hide all virtual text errors
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    if require('plugins.lsp.utils').show_diagnostics() then
      vim.diagnostic.config { virtual_text = false }
      vim.schedule(vim.diagnostic.open_float)
    end
  end,
  group = augroup 'CursorHold',
})

-- start git messages in insert mode
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'buf_check',
  pattern = { 'NeogitCommitMessage' },
  command = 'startinsert | 1',
})

-- autocmd for autocmd ColorScheme zenbones lua require "customize_zenbones"
vim.api.nvim_create_autocmd('ColorScheme', {
  group = augroup 'customize_zenbones',
  pattern = '*',
  command = "lua require('customize_zenbones')",
})
