return {
  {
    -- TODO: v2 https://github.com/ThePrimeagen/harpoon
    "ThePrimeagen/harpoon",
    lazy = true,
    event = "VeryLazy",
    config = function()
      local wk = require "which-key"
      wk.register({
        name = "Jump",
        w = { "<Cmd>lua require('harpoon.mark').add_file()<Cr>", "Add File" },
        e = { "<Cmd>lua require('harpoon.ui').toggle_quick_menu()<Cr>", "UI Menu" },
        c = { "<Cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<Cr>", "Command Menu" },
        ["a"] = { "<Cmd>lua require('harpoon.ui').nav_file(1) <Cr>", "which_key_ignore" },
        ["s"] = { "<Cmd>lua require('harpoon.ui').nav_file(2) <Cr>", "which_key_ignore" },
        ["d"] = { "<Cmd>lua require('harpoon.ui').nav_file(3) <Cr>", "which_key_ignore" },
        ["f"] = { "<Cmd>lua require('harpoon.ui').nav_file(4) <Cr>", "which_key_ignore" },
      }, { prefix = "<localleader>" })
    end,
    opts = {
      global_settings = {
        save_on_toggle = true,
        enter_on_sendcmd = true,
      },
    },
  },
}
