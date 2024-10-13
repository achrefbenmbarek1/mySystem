return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("harpoon").setup({
      global_settings = {
        enter_on_sendcmd = true,
      },
      projects = {
    ["$HOME/Document/projects/axeFinance/PublisherService/"] = {
        term = {
            cmds = {
                "dotnet watch",
              "dotnet watch"
            }
        }
    }
}
    })
    local opts = { nowait = true }
    local keymap = vim.keymap
    local globalHarpoonLeader = "<leader>H"
    opts.desc = "toggle harpoon menu for files"
    keymap.set("n", "<leader>Hm", function()
      require("harpoon.ui").toggle_quick_menu()
    end, opts)
    opts.desc = "add file to menu"
    keymap.set("n", globalHarpoonLeader .. "a", function()
      require("harpoon.mark").add_file()
    end, opts)
    local keysThatMapsToAHarpoonBuffer = { "h", "j", "k", "l" }
    local numberOfFilesInHarpoon = #keysThatMapsToAHarpoonBuffer
    for i = 1, numberOfFilesInHarpoon, 1 do
      opts.desc = "go to file " .. i
      keymap.set("n","<leader>H" .. keysThatMapsToAHarpoonBuffer[i], function()
        require("harpoon.ui").nav_file(i)
      end, opts)
    end
    opts.desc = "next"
    keymap.set("n", globalHarpoonLeader .. "n", function()
      require("harpoon.ui").nav_next()
    end, opts)
    opts.desc = "prev"
    keymap.set("n", globalHarpoonLeader .. "p", function()
      require("harpoon.ui").nav_prev()
    end, opts)
    opts.desc = "go to backend terminal"
    keymap.set("n", globalHarpoonLeader .. "gtb", function()
      require("harpoon.tmux").gotoTerminal(1)
    end, opts)
    opts.desc = "go to frontend terminal"
    keymap.set("n", globalHarpoonLeader .. "gtf", function()
      require("harpoon.tmux").gotoTerminal(2)
    end, opts)
    opts.desc = "send start server command to backend terminal"
    keymap.set("n", globalHarpoonLeader .. "sb", function()
      require("harpoon.tmux").sendCommand(1, 1)
    end, opts)
  end,
}
