return {
  "ggandor/leap.nvim",
  event = "VeryLazy",
  dependencies = { "tpope/vim-repeat" },
  config = function()
    vim.keymap.set({ "n", "x", "o" }, "<leader>s", "<Plug>(leap-forward)")
    vim.keymap.set({ "n", "x", "o" }, "<leader>S", "<Plug>(leap-backward)")
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
  end,
}
