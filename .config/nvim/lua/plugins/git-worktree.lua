return {
  "ThePrimeagen/git-worktree.nvim",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("git-worktree").setup()
    require("telescope").load_extension("git_worktree")
    local keymap = vim.keymap
    keymap.set("n", "<leader>gw", function()
      require("telescope").extensions.git_worktree.git_worktrees()
    end)

    keymap.set("n", "<leader>gW", function()
      require("telescope").extensions.git_worktree.create_git_worktree()
    end)
  end,


}
