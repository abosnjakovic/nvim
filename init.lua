pcall(require, 'config.options')
pcall(require, 'config.lazy')

if vim.loader then
  vim.loader.enable()
end

pcall(require, 'config.autocmds')
pcall(require, 'config.keymaps')

-- local ok, t = pcall(require, 'config.theme')
-- if ok then
--   t.setup()
-- end
