local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Go to previous file with backspace
keymap("n", "<BS>", ":lua require('harpoon.ui').nav_next()<CR>", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Browser search
keymap("n", "gx", "<Plug>(openbrowser-smart-search)", default_opts)
keymap("x", "gx", "<Plug>(openbrowser-smart-search)", default_opts)

-- run lua code
keymap("n", "<M-l>", ":up<CR> :source %<cr> h", { noremap = true, silent = true })
keymap("i", "<M-l>", "<ESC> :up<CR> :source %<cr> h", { noremap = true, silent = true })

-- Delete window
keymap("n", "qq", ":lua require('mini.bufremove').delete(0, false)<CR>", default_opts)

-- Allow gf to open non-existent files
keymap("n", "gf", ":edit <cfile><cr>", default_opts)

-- Switch buffer
keymap("n", "<S-h>", ":tabprevious<cr>", default_opts)
keymap("n", "<S-l>", ":tabnext<cr>", default_opts)

-- update the files
keymap("n", "<C-s>", ":update!<CR>", default_opts)
keymap("i", "<C-s>", "<ESC> :update!<CR>", default_opts)
keymap("n", "<c-x>", ":! ", default_opts)
keymap("n", "<c-x>", ":%s/<C-r><C-w>/", default_opts)

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Center search results
-- keymap("n", "n", "nzz", default_opts)
-- keymap("n", "N", "Nzz", default_opts)

-- Scrolling
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- -- Always center
keymap("n", "k", "kzz", default_opts)
keymap("n", "j", "jzz", default_opts)
keymap("n", "G", "Gzz", default_opts)

-- Paste
keymap("n", "]p", "o<Esc>p", { desc = "Paste below" })
keymap("n", "]P", "O<Esc>p", { desc = "Paste above" })

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>")
keymap("t", "jk", "<C-\\><C-n>")
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dp')

-- Resize window using <shift> arrow keys
keymap("n", "<S-Up>", "<cmd>resize +2<CR>")
keymap("n", "<S-Down>", "<cmd>resize -2<CR>")
keymap("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
keymap("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Insert blank line
keymap("n", "]<Space>", "o<Esc>")
keymap("n", "[<Space>", "O<Esc>")

-- Auto indent
keymap("n", "i", function()
  if #vim.fn.getline "." == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true })

-- Function to close windows displaying buffers of a certain type
function close_windows_by_buffer_type(buf_type)
  vim.cmd [[call setqflist([])]]
  for _, winid in ipairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(winid)
    local win_type = vim.api.nvim_buf_get_option(bufnr, "buftype")
    if win_type == buf_type then
      vim.api.nvim_win_close(winid, true)
    else
      return nil
    end
  end
end

keymap("n", "<leader>cc", ":lua close_windows_by_buffer_type('quickfix')<CR>", default_opts)
