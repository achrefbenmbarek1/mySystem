return {
  "mfussenegger/nvim-dap",
  config = function(_, opts)
    require("core.utils").load_mappings("dap")
  end,
}
