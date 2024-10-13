return {
  "nvim-neotest/neotest",
  dependencies = {
    "Issafalcon/neotest-dotnet",
    "nvim-neotest/nvim-nio"
  },
  lazy = false,
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-dotnet"),
      },
    })
  end,
}
