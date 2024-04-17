local M = {}

function M.setup()
  local dap = require "dap"
  local vitest = "node_modules/vitest/vitest.mjs"
  --[[ local jestGlobal = "/home/adam/Repositories/jest/packages/jest/bin/jest.js" ]]
  local jestGlobal = "/home/adam/.npm/jest"
  local jestLocal = "node_modules/jest/bin/jest.js"

  require("dap-vscode-js").setup {
    -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
    debugger_path = "/home/adam/.local/share/nvim/lazy/vscode-js-debug", -- Path to vscode-js-debug installation.
    -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
  }

  for _, language in ipairs { "typescript", "javascript", "typescriptreact", "tsserver" } do
    dap.configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests O",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
          "--",
          "${file}",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },

      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Vite Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        smartStep = true,
        autoAttachChildProcesses = true,
        runtimeArgs = {
          vitest,
          "--inspect-brk",
          "--threads=false",
          "--watch",
          "--",
          "${file}",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          --[[ "./node_modules/jest/bin/jest.js", ]]
          jestLocal,
          "--inspect-brk",
          "--runInBand",
          --[[ "--watch-all", ]]
          "--no-cache",
          "--detectOpenHandles",
          "--",
          "${file}",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      {
        -- For this to work you need to make sure the node process is started with the `--inspect` flag.
        name = "Attach to process",
        type = "node2",
        request = "attach",
        processId = require("dap.utils").pick_process,
      },
      --[[ { ]]
      --[[   "name": "Docker: Attach to Node", ]]
      --[[   "type": "node", ]]
      --[[   "request": "attach", ]]
      --[[   "port": 9229, ]]
      --[[   "address": "localhost", ]]
      --[[   "localRoot": "${workspaceFolder}", ]]
      --[[   "remoteRoot": "/", ]]
      --[[   "protocol": "inspector" ]]
      --[[ } ]]

      -- TODO: pwa-chrome setup?
      -- npx nodemon --exec node --inspect-brk=0.0.0.0:9229 --require ts-node/register <file>

      --[[ { ]]
      --[[   name = "Debug Main Process (Electron)", ]]
      --[[   type = "pwa-node", ]]
      --[[   request = "launch", ]]
      --[[   program = "${workspaceFolder}/node_modules/.bin/electron", ]]
      --[[   args = { ]]
      --[[     "${workspaceFolder}/dist/index.js", ]]
      --[[   }, ]]
      --[[   outFiles = { ]]
      --[[     "${workspaceFolder}/dist/*.js", ]]
      --[[   }, ]]
      --[[   resolveSourceMapLocations = { ]]
      --[[     "${workspaceFolder}/dist/**/*.js", ]]
      --[[     "${workspaceFolder}/dist/*.js", ]]
      --[[   }, ]]
      --[[   rootPath = "${workspaceFolder}", ]]
      --[[   cwd = "${workspaceFolder}", ]]
      --[[   sourceMaps = true, ]]
      --[[   skipFiles = { "<node_internals>/**" }, ]]
      --[[   protocol = "inspector", ]]
      --[[   console = "integratedTerminal", ]]
      --[[ }, ]]
      --[[ { ]]
      --[[   name = "Compile & Debug Main Process (Electron)", ]]
      --[[   type = custom_adapter, ]]
      --[[   request = "launch", ]]
      --[[   preLaunchTask = "npm run build-ts", ]]
      --[[   program = "${workspaceFolder}/node_modules/.bin/electron", ]]
      --[[   args = { ]]
      --[[     "${workspaceFolder}/dist/index.js", ]]
      --[[   }, ]]
      --[[   outFiles = { ]]
      --[[     "${workspaceFolder}/dist/*.js", ]]
      --[[   }, ]]
      --[[   resolveSourceMapLocations = { ]]
      --[[     "${workspaceFolder}/dist/**/*.js", ]]
      --[[     "${workspaceFolder}/dist/*.js", ]]
      --[[   }, ]]
      --[[   rootPath = "${workspaceFolder}", ]]
      --[[   cwd = "${workspaceFolder}", ]]
      --[[   sourceMaps = true, ]]
      --[[   skipFiles = { "<node_internals>/**" }, ]]
      --[[   protocol = "inspector", ]]
      --[[   console = "integratedTerminal", ]]
      --[[ }, ]]
    }
  end
end

return M
