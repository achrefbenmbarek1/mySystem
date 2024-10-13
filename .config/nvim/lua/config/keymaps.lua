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

-- keymap.set("n", "<leader>e", "<cmd> NvimTreeToggle <CR>", { noremap = true, silent = true })
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

-- keymap.set("n", "<leader>cc", "<cmd> lua compile() <CR>", {})

keymap.set("n", "<leader>cj", "<cmd>wa<CR><cmd>!mvn compile > /dev/null 2>&1<CR>", { nowait = true, silent = true })

keymap.set("n", "<leader>cx", "<cmd>!chmod +x %<CR>", { nowait = true, silent = true })

keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")
keymap.set("n", "<leader>Nw", "<cmd> Neorg index<CR>", { nowait = true, silent = true })
keymap.set("n", "<leader>Nr", "<cmd> Neorg return<CR>", { nowait = true, silent = true })
keymap.set("n", "<leader>i", function()
  -- Get the word under the cursor
  local image = vim.fn.expand("%")
  local imageExtenstion = vim.fn.expand("%:e")
  local validExtensions = { "jpg", "jpeg", "png", "gif", "bmp" }
  local function isValidExtension(ext)
    ext = ext:lower()  -- Convert the extension to lowercase for case-insensitive comparison
    for _, valid_ext in ipairs(validExtensions) do
        if ext == valid_ext then
            return true
        end
    end
    return false
end
  if isValidExtension(imageExtenstion) then
    os.execute("vimiv " .. vim.fn.shellescape(image) .. " &")
  else
    print("Not an image file")
    print(vim.fn.expand("%"))
  end
end, { nowait = true, silent = true })

