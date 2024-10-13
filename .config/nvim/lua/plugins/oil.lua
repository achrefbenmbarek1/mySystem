return {
  "stevearc/oil.nvim",
  opts = {},
  lazy = false,
  config = function()
    require("oil").setup({ default_file_explorer = true })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
