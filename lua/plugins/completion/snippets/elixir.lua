local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local l = require("luasnip.extras").lambda

local snippets = {
  ls.parser.parse_snippet("heex", 'def render(assigns) do \n~H"""\n""" \nend'),

  ls.parser.parse_snippet("mount", "def mount(_params, _session, socket) do \n{:ok, socket} \nend"),
}

return snippets
