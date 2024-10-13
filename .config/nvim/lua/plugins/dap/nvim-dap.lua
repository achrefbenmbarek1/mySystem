return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
  },
  lazy = false,
  config = function(_, opts)
    local dap = require("dap")
    require("nvim-dap-virtual-text").setup()

    dap.adapters.coreclr = {
      type = "executable",
      command = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/netcoredbg/libexec/netcoredbg/netcoredbg",
      args = { "--interpreter=vscode" },
    }
    dap.adapters.netcoredbg = {
      type = "executable",
      command = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/netcoredbg/libexec/netcoredbg/netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
    }

    vim.keymap.set("n", "<F4>", "<cmd>lua require('dap').continue()<CR>")
    vim.keymap.set("n", "<F1>", "<cmd>lua require('dap').step_over()<CR>")
    vim.keymap.set("n", "<F2>", "<cmd>lua require('dap').step_into()<CR>")
    vim.keymap.set("n", "<F3>", "<cmd>lua require('dap').step_out()<CR>")
    vim.keymap.set("n", "<leader>B", "<cmd>lua require('dap').toggle_breakpoint()<CR>")
  end,
}
