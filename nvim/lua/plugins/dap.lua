return {
	--[[ {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb", -- adjust as needed, must be absolute path
        name = "lldb",
      }
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-nvim-dap").setup({
        handlers = {},
        ensure_installed = { "lldb" }, -- or 'lldb'
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapUi = require("dapui")
      dapUi.setup()
      dap.listeners.after.event_initilized["dapui_config"] = function()
        dapUi.open()
      end
      dap.listeners.after.evenet_terminated["dapui_config"] = function()
        dapUi.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function()
        dapUi.close()
      end
    end,
  }, ]]
}
