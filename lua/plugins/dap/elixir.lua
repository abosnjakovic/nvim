local M = {}

function M.setup()
  local dap = require "dap"

  dap.adapters.mix_task = {
    type = "executable",
    command = "/home/adam/.local/share/nvim/mason/bin/elixir-ls-debugger", -- debugger.bat for windows
    args = {},
  }

  dap.configurations.elixir = {
    {
      type = "mix_task",
      name = "mix test",
      task = "test",
      taskArgs = { "--trace" },
      request = "launch",
      startApps = true, -- for Phoenix projects
      projectDir = "${workspaceFolder}",
      requireFiles = {
        "test/**/test_helper.exs",
        "test/**/*_test.exs",
      },
    },

    {
      type = "test.interactive",
      name = "mix interactive",
      task = "test",
      taskArgs = { "--trace" },
      request = "launch",
      startApps = true, -- for Phoenix projects
      projectDir = "${workspaceFolder}",
    },
    {
      type = "mix_task",
      name = "phx.server",
      request = "launch",
      startApps = false, -- for Phoenix projects
      task = "phx.server",
      projectDir = "${workspaceRoot}",
    },
  }
end

return M
