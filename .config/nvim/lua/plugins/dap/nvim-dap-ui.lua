return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
    vim.keymap.set("n", "<leader>dt", "<cmd>lua require('dapui').toggle()<CR>")
    vim.keymap.set("n", "<leader>do", "<cmd>lua require('dapui').open()<CR>")
    vim.keymap.set("n", "<leader>dc", "<cmd>lua require('dapui').close()<CR>")
  end,
}
