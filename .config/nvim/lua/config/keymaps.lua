local keymap = vim.keymap

function compile(file, output)
  local extension = file:match("%.([^%.]+)$")
  if extension == "c" then
    return os.execute("gcc -Wall -o " .. output .. " " .. file)
  elseif extension == "cpp" then
    return os.execute("g++ -Wall -o " .. output .. " " .. file)
  else
    return "The file extension of your source code is either not supported yet or you misspelled it"
  end
end

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
  -- local outputFilename = vim.fn.input("Enter output filename: ")
  -- local command = string.format("zsh -ic 'compile %s \"%s\"'", vim.fn.expand("%:p"), input)
  -- local output = vim.fn.systemlist(command)
  -- local sourceFilePath = vim.fn.expand("%:p")
  -- local output = compile(sourceFilePath, outputFilename)
  -- local newBuf = vim.api.nvim_create_buf(false, true)
  -- vim.api.nvim_buf_set_lines(newBuf, 0, -1, false, { tostring(output) })
  -- local opts = {
  --   relative = "editor",
  --   width = vim.o.columns - 30,
  --   height = vim.o.lines - 20,
  --   row = 2,
  --   col = 2,
  --   style = "minimal",
  --   border = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  -- }
  -- local win = vim.api.nvim_open_win(newBuf, true, opts)
  -- vim.api.nvim_win_set_option(win, "wrap", true)

  --[[ if vim.v.shell_error == 0 then
    vim.cmd("echo ' Compilation successful'")
  else
    vim.api.nvim_open_win(newBuf, true, opts)
  end ]]
  local outputFilename = vim.fn.input("Enter output filename: ")
  local sourceFilePath = vim.fn.expand("%:p")
  local output = compile(sourceFilePath, outputFilename)

  local lines = { tostring(output) }
  local max_width = 0

  -- Calculate max width and prepare lines
  for _, line in ipairs(lines) do
    max_width = math.max(max_width, #line)
  end

  local newBuf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_buf_set_lines(newBuf, 0, -1, false, {"hey is this working, please do work and let me say programmmmmmmmmerrrrrrrrrr", "I hope so"})
  vim.api.nvim_set_current_buf(newBuf)

  local width = max_width + 4 -- Adjust width based on content
  local height = #lines + 4 -- Adjust height based on content

  local win = vim.api.nvim_open_win(newBuf, true, {
    relative = "editor",
    width = vim.o.lines,
    height = vim.o.columns,
    row = vim.o.lines,
    col = vim.o.columns,
    style = "minimal",
    border = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
  })

  vim.api.nvim_win_set_option(win, "wrap", false)
  -- vim.api.nvim_win_set_option(win, "winblend", 0)
end, {})
-- keymap.set("n", "<leader>cc", "<cmd> lua compile() <CR>", {})

keymap.set("n", "<leader>cj", "<cmd>wa<CR><cmd>!mvn compile > /dev/null 2>&1<CR>", { nowait = true, silent = true })

keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { nowait = true, silent = true })

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
