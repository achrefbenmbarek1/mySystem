local keymap = vim.keymap
local api = vim.api

keymap.set("n", "<leader>e", "<cmd> NvimTreeToggle <CR>", { noremap = true, silent = true })
keymap.set("n", "<C-d>", "<C-d>zz", { nowait = true })
keymap.set("n", "<C-u>", "<C-u>zz", { nowait = true })
keymap.set("n", "<leader>+", "<cmd>vertical resize +10 <CR>", { nowait = true })
keymap.set("n", "<leader>-", "<cmd>vertical resize -10 <CR>", { nowait = true })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { nowait = true })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { nowait = true })
keymap.set({ "n", "v" }, "<leader>mp", '"+p', { nowait = true })
keymap.set({ "v", "n" }, "<leader>my", '"+y', { nowait = true })
keymap.set({ "v", "n" }, "<leader>md", '"_d', { nowait = true })
keymap.set("n", "<leader>mr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("i", "jk", "<Esc>", { nowait = true, noremap = true })
keymap.set("n", "<A-l>", "<cmd> noh <CR>")

keymap.set("n", "<leader>cc", function()
  local input = vim.fn.input("Enter string: ")
  local command = string.format("zsh -ic 'compile %s \"%s\"'", vim.fn.expand("%:p"), input)
  local output = vim.fn.system(command)

  if vim.v.shell_error == 0 then
    vim.cmd("echo ' Compilation successful'")
  else
    vim.cmd("echo ' Compilation failed'")
    print(output)
  end
end, {})
-- keymap.set("n", "<leader>cc", "<cmd> lua compile() <CR>", {})

keymap.set("n", "<leader>cj", "<cmd>wa<CR><cmd>!mvn compile > /dev/null 2>&1<CR>", { nowait = true, silent = true })

keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { nowait = true, silent = true })
api.nvim_set_keymap("n", "<leader>/", "gcc", { nowait = true })
api.nvim_set_keymap("v", "<leader>/", "gcc", { nowait = true })

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
