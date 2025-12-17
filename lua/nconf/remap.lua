-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better paste behavior
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- ?
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- -- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e $MYVIMRC<CR>", { desc = "Edit config" })
vim.keymap.set("n", "<leader>rl", ":so $MYVIMRC<CR>", { desc = "Reload config" }) -- Copy Full File-Path
vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end)

-- Normal mode mappings
vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- telescope mapings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Search git files" })
vim.keymap.set("n", "<leader>fl", builtin.live_grep, { desc = "Live grep" })
--vim.keymap.set('n', ';', builtin.buffers, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search buffers" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help tags" })

-- Diagnostics
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })

-- Nvim tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Diagnostics to location list", noremap = true })

-- lsp keymaps
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go to definition", noremap = true })
vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, { desc = "Go to implementation", noremap = true })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover info", noremap = true })
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, { desc = "Rename symbol", noremap = true })
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Code action", noremap = true })
vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, { desc = "Go to refrences", noremap = true })

-- execute current python file

-- If this is a script, make it executable, and execute it in a split pane on the right
-- Had to include quotes around "%" because there are some apple dirs that contain spaces, like iCloud
vim.keymap.set("n", "<leader>f.", function()
	local file = vim.fn.expand("%") -- Get the current file name
	local filetype = vim.bo.filetype -- Get the current filetype
	local first_line = vim.fn.getline(1) -- Get the first line of the file
	local escaped_file = vim.fn.shellescape(file) -- Properly escape the file name for shell commands

	if filetype == "python" then
		vim.cmd("vsplit") -- Split the window vertically
		vim.cmd("terminal python3 " .. escaped_file) -- Run with python3
		vim.cmd("startinsert")
	elseif string.match(first_line, "^#!/") then -- If first line contains shebang
		vim.cmd("!chmod +x " .. escaped_file) -- Make the file executable
		vim.cmd("vsplit") -- Split the window vertically
		vim.cmd("terminal " .. escaped_file) -- Open terminal and execute the file
		vim.cmd("startinsert") -- Enter insert mode, recommended by echasnovski on Reddit
	else
		vim.cmd("echo 'Not a script. Shebang line not found.'")
	end
end, { desc = "Execute current file in terminal (if it's a script)" })



local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end, { desc = "Add file to Harpoon" })
vim.keymap.set("n", "<leader>ho", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Toggle Harpoon menu" })
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Go to Harpoon file 1" })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Go to Harpoon file 2" })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Go to Harpoon file 3" })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Go to Harpoon file 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Previous Harpoon file" })
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Next Harpoon file" })