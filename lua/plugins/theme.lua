local M = {}
local hl = vim.api.nvim_set_hl

vim.opt.termguicolors = true

M.colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67',
}

function M.trans()
  -- transparent background
  hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'NormalFloat', { bg = 'none' })
  hl(0, 'TelescopeBorder', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'TelescopePromptBorder', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'TelescopePreviewBorder', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'TelescopeResultsBorder', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'WhichKeyFloat', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'WinSeparator', { bg = 'NONE', ctermbg = 'NONE', fg = 'NONE', ctermfg = 'NONE' })
  hl(0, 'LineNr', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'SignColumn', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'Pmenu', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'PmenuSel', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'vertsplit', { bg = 'NONE', ctermbg = 'NONE' })
  hl(0, 'MsgArea', { bg = 'NONE', ctermbg = 'NONE' })

  hl(0, 'HoverNormal', { bg = 'NONE', ctermbg = 'NONE', fg = 'NONE', ctermfg = 'NONE' })
end

function M.base16()
  local fn = vim.fn
  local cmd = vim.cmd
  local set_theme_path = '$HOME/.config/tinted-theming/set_theme.lua'
  local is_set_theme_file_readable = fn.filereadable(fn.expand(set_theme_path)) == 1 and true or false

  if is_set_theme_file_readable then
    cmd 'let base16colorspace=256'
    cmd('source ' .. set_theme_path)
  end
end

function M.setup()
  -- M.buddy() -- colorbuddy gruvbuddy
  M.trans()

  vim.opt.listchars = {
    eol = '↲',
    nbsp = '◡',
    conceal = '∫',
    extends = '≯',
    precedes = '≮',
    tab = '  ',
  }

  vim.opt.list = true
  vim.opt.termguicolors = true
  vim.opt.winblend = 0
  vim.opt.pumblend = 0
  vim.opt.cmdheight = 0

  hl(0, 'CopilotSuggestion', { fg = '#ff42cf' })
  hl(0, 'CopilotAnnotation', { fg = '#ff42cf' })
  hl(0, 'FlashLabel', { fg = '#ff42cf' })

  -- change Function to be pink
  -- hl(0, "Function", { fg = "#ff2afc" })
end

function M.buddy()
  rawset(require('colorbuddy').styles, 'italic', require('colorbuddy').styles.none)

  require('colorbuddy').colorscheme 'gruvbuddy'
  require('colorizer').setup()

  local c = require('colorbuddy.color').colors
  local Group = require('colorbuddy.group').Group
  local g = require('colorbuddy.group').groups
  local s = require('colorbuddy.style').styles

  Group.new('@variable', c.superwhite, nil)

  Group.new('GoTestSuccess', c.green, nil, s.bold)
  Group.new('GoTestFail', c.red, nil, s.bold)

  -- Group.new('Keyword', c.purple, nil, nil)

  Group.new('TSPunctBracket', c.orange:light():light())

  Group.new('StatuslineError1', c.red:light():light(), g.Statusline)
  Group.new('StatuslineError2', c.red:light(), g.Statusline)
  Group.new('StatuslineError3', c.red, g.Statusline)
  Group.new('StatuslineError3', c.red:dark(), g.Statusline)
  Group.new('StatuslineError3', c.red:dark():dark(), g.Statusline)

  Group.new('pythonTSType', c.red)
  Group.new('goTSType', g.Type.fg:dark(), nil, g.Type)

  Group.new('typescriptTSConstructor', g.pythonTSType)
  Group.new('typescriptTSProperty', c.blue)

  -- vim.cmd [[highlight WinSeparator guifg=#4e545c guibg=None]]
  Group.new('WinSeparator', nil, nil)

  -- I don't think I like highlights for text
  -- Group.new("LspReferenceText", nil, c.gray0:light(), s.bold)
  -- Group.new("LspReferenceWrite", nil, c.gray0:light())

  -- Group.new("TSKeyword", c.purple, nil, s.underline, c.blue)
  -- Group.new("LuaFunctionCall", c.green, nil, s.underline + s.nocombine, g.TSKeyword.guisp)

  Group.new('TSTitle', c.blue)

  -- TODO: It would be nice if we could only highlight
  -- the text with characters or something like that...
  -- but we'll have to stick to that for later.
  Group.new('InjectedLanguage', nil, g.Normal.bg:dark())

  Group.new('LspParameter', nil, nil, s.italic)
  Group.new('LspDeprecated', nil, nil, s.strikethrough)
  Group.new('@function.bracket', g.Normal, g.Normal)
  Group.new('@variable.builtin', c.purple:light():light(), g.Normal)

  -- Group.new("VirtNonText", c.yellow:light():light(), nil, s.italic)
  Group.new('VirtNonText', c.gray3:dark(), nil, s.italic)

  Group.new('TreesitterContext', nil, g.Normal.bg:light())
  Group.new('TreesitterContextLineNumber', c.blue)
  -- hi TreesitterContextBottom gui=underline guisp=Grey
  -- Group.new("TreesitterContextBottom", nil, nil, s.underline)

  Group.new('@property', c.blue)
  Group.new('@punctuation.bracket.rapper', c.gray3, nil, s.none)
  Group.new('@rapper_argument', c.red, nil, s.italic)
  Group.new('@rapper_return', c.orange:light(), nil, s.italic)
  Group.new('@constructor.ocaml', c.orange:light(), nil, s.none)
  Group.new('constant', c.orange, nil, s.none)

  Group.new('@keyword', c.violet, nil, s.none)
  Group.new('@keyword.faded', g.nontext.fg:light(), nil, s.none)
  -- Group.new("@keyword.faded", c.green)

  Group.new('Function', c.yellow, nil, s.none)

  -- hop
  Group.new('HopNextKey', c.pink, nil, s.bold)
  Group.new('HopNextKey1', c.cyan:saturate(), nil, s.bold)
  Group.new('HopNextKey2', c.cyan:dark(), nil)

  -- signs
  Group.new('GitSignsAdd', c.green)
  Group.new('GitSignsChange', c.yellow)
  Group.new('GitSignsDelete', c.red)

  -- completion
  Group.new('CmpItemAbbr', g.Comment)
  Group.new('CmpItemAbbrDeprecated', g.Error)
  Group.new('CmpItemAbbrMatchFuzzy', g.CmpItemAbbr.fg:dark(), nil, s.italic)
  Group.new('CmpItemKind', g.Special)
  Group.new('CmpItemMenu', g.NonText)

  Group.new('TelescopeNormal', nil, nil)

  Group.new('DiagosticVirtualTextOk', g.Comment)
  Group.new('DiagnosticVirtualTextInfo', g.Comment)

  vim.cmd [[
  hi link @function.call.lua LuaFunctionCall
  hi link @lsp.type.variable.lua variable
  hi link @lsp.type.variable.ocaml variable
  hi link @lsp.type.variable.rust variable
  hi link @lsp.type.namespace @namespace
  hi link @punctuation.bracket.rapper @text.literal
  hi link @normal Normal
]]

  Group.new('Normal', c.superwhite, c.gray0)
end

return {
  {
    'abosnjakovic/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    priority = 1000,
    lazy = false,
    enabled = true,
    config = function()
      -- zenwritten	Zero hue and saturation version
      -- neobones	Inspired by neovim.io
      -- vimbones	Inspired by vim.org
      -- rosebones	Inspired by Rosé Pine
      -- forestbones	Inspired by Everforest
      -- nordbones	Inspired by Nord
      -- tokyobones	Inspired by Tokyo Night
      -- seoulbones	Inspired by Seoul256
      -- duckbones	Inspired by Spaceduck
      -- zenburned	Inspired by Zenburn
      -- kanagawabones	Inspired by Kanagawa
      -- randombones	Randomly pick from the collection.

      local base = require 'zenbones'
      local colors = 'duckbones'

      vim.g[colors .. '_solid_line_nr'] = true
      vim.g[colors .. '_darken_comments'] = 45
      vim.g[colors .. '_transparent_background'] = true
      vim.g[colors .. '_colorize_diagnostic_underline_text'] = true

      local lush = require 'lush'
      local base = require 'zenbones'

      -- Create some specs
      local specs = lush.parse(function()
        return {
          Function { base.Function, fg = '#ff42cf' },
        }
      end)
      -- Apply specs using lush tool-chain
      lush.apply(lush.compile(specs))

      vim.cmd('colorscheme ' .. colors)
    end,
  },

  {
    'tjdevries/colorbuddy.vim',
    dependencies = { 'tjdevries/gruvbuddy.nvim', 'bbenzikry/snazzybuddy.nvim', 'svrana/neosolarized.nvim' },
    priority = 1000,
    lazy = false,
    event = 'VeryLazy',
    config = function()
      -- require('plugins.theme.style').setup()
    end,
  },

  {
    'norcalli/nvim-colorizer.lua',
    {
      'norcalli/nvim-terminal.lua',
      config = function()
        require('terminal').setup()
      end,
    },
  },

  {
    'nvim-tree/nvim-web-devicons',
    dependencies = { 'DaikyXendo/nvim-material-icon' },
    config = function()
      require('nvim-web-devicons').setup {
        override = require('nvim-material-icon').get_icons(),
      }
    end,
  },
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = { relative = 'editor' },
      select = {
        backend = { 'telescope', 'fzf', 'builtin' },
      },
    },
  },
  {
    'echasnovski/mini.indentscope',
    lazy = true,
    event = 'VeryLazy', -- "BufReadPre", "BufNewFile
    version = '*',
    config = function()
      require('mini.indentscope').setup { symbol = '│', options = { try_as_border = true } }
    end,
  },
}
