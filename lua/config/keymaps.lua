vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
local map = vim.api.nvim_set_keymap

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<A-c>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "<A-c>", "<Esc>", opts)
vim.keymap.set("v", "<A-c>", "<Esc>", opts)
vim.keymap.set("t", "<A-c>", "<C-\\><C-n>", opts) -- Exit terminal mode

-- Recording macros and behavior changes
vim.keymap.set("n", "m", "q", opts) -- Start recording macro with "m"
vim.keymap.set("n", "M", "q", opts)
vim.keymap.set("n", "Q", "I", opts) -- Make "Q" behave like "I"
vim.keymap.set("n", "q", "i", opts) -- Make "q" behave like "i"

-- Indentation and moving down
vim.keymap.set("n", "+", "=", opts) -- Use + for indentation
vim.keymap.set("n", "=", "+", opts) -- Use = for moving down
vim.keymap.set("v", "+", "=", opts) -- Use + for indentation
vim.keymap.set("v", "=", "+", opts) -- Use = for moving down

-- Word navigation
vim.keymap.set("n", "w", "b", opts) -- Move back with "w"
vim.keymap.set("v", "w", "b", opts)

vim.keymap.set("n", "e", "w", opts) -- Move forward with "e"
vim.keymap.set("v", "e", "w", opts)

vim.keymap.set("n", "}", "<C-d>", opts)

vim.keymap.set("n", "{", "<C-u>", opts)

vim.keymap.set("n", "<C-x>", "<Plug>(matchup-%)", { desc = "Navigate to matching HTML tag/bracket" })
vim.keymap.set("v", "<C-x>", "<Plug>(matchup-%)", { desc = "Navigate to matching HTML tag/bracket" })

-- Additional vim-matchup keymaps for enhanced HTML navigation
vim.keymap.set("n", "g%", "<Plug>(matchup-g%)", { desc = "Navigate backwards to matching tag" })
vim.keymap.set("x", "g%", "<Plug>(matchup-g%)", { desc = "Navigate backwards to matching tag" })
vim.keymap.set("o", "g%", "<Plug>(matchup-g%)", { desc = "Navigate backwards to matching tag" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<A-left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<A-right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<A-down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<A-up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("i", "<C-x>", "<Plug>(copilot-dismiss)", { silent = true })
vim.keymap.set("n", "ZZ", "<Nop>", { noremap = true, silent = true })
vim.keymap.set({ "n", "o" }, "Z", "$", { noremap = true, silent = true })
-- local marks
vim.api.nvim_set_keymap("n", "b", "m", { noremap = true })
--
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<A-j>", ":lnext<CR>", { silent = true, desc = "Location List Next" })
vim.keymap.set("n", "<A-k>", ":lprev<CR>", { silent = true, desc = "Location List Previous" })

vim.api.nvim_set_keymap("n", "<A-=>", ":bd!<CR>", { noremap = true, silent = true })

-- Global variables to store terminal window and buffer IDs
local term_win_id = nil

local term_buf_id = nil

---------------------------------------------------------------------
---harpoon keymaps---------------------------------------------------

vim.keymap.set("n", "<leader>ha", function()
	require("harpoon.mark").add_file()
end, { desc = "Harpoon Add File" })

vim.keymap.set("n", "<leader>hm", function()
	require("harpoon.ui").toggle_quick_menu()
end, { desc = "Harpoon Menu" })

--------free this keys for harpoon
vim.keymap.set("n", "<leader>>", ">>", { desc = "Indent Right" })
vim.keymap.set("v", "<leader>>", ">gv", { desc = "Indent Right (Visual)" })

vim.keymap.set("n", "<leader>]", "<C-]>", { desc = "Indent Left" })
vim.keymap.set("n", "<leader>[", "<C-[>", { desc = "Indent Left (Visual)" })
vim.keymap.set("n", "<leader>p", "<C-p>", { desc = "Indent Left (Visual)" })
vim.keymap.set("n", "<leader>o", "<C-o>", { desc = "Indent Left (Visual)" })

-- Map leader + < for indent left
vim.keymap.set("n", "<leader><", "<<", { desc = "Indent Left" })
vim.keymap.set("v", "<leader><", "<gv", { desc = "Indent Left (Visual)" })

-- Helper function to determine current working directory (same logic as ToggleBottomTerminal)
local function get_current_working_directory()
	local bufn = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufn)
	local cwd = ""
	if bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
		cwd = vim.fn.fnamemodify(bufname, ":p:h")
	else
		cwd = vim.fn.getcwd()
	end
	return cwd
end

-- Wrapper functions for harpoon terminals that set working directory
local function goto_harpoon_terminal(term_num)
	local cwd = get_current_working_directory()

	-- Get or create the terminal
	require("harpoon.term").gotoTerminal(term_num)

	-- Set the working directory if valid
	if cwd ~= "" and vim.fn.isdirectory(cwd) == 1 then
		-- Send 'cd' command to the terminal
		local escaped_cwd = vim.fn.fnameescape(cwd)
		require("harpoon.term").sendCommand(term_num, "cd " .. escaped_cwd .. "&& cls")
	end
end

vim.keymap.set("n", "<A-1>", function()
	goto_harpoon_terminal(1)
end, { noremap = true, silent = true })

vim.keymap.set("n", "<A-2>", function()
	goto_harpoon_terminal(2)
end, { noremap = true, silent = true })

vim.keymap.set("n", "<A-3>", function()
	goto_harpoon_terminal(3)
end, { noremap = true, silent = true })

vim.keymap.set("n", "<A-4>", function()
	goto_harpoon_terminal(4)
end, { noremap = true, silent = true })

-------------------------------------

vim.keymap.set("n", ">", function()
	require("harpoon.ui").nav_next()
end, { desc = "Harpoon Next" })
vim.keymap.set("n", "<", function()
	require("harpoon.ui").nav_prev()
end, { desc = "Harpoon Previous" })

vim.keymap.set("n", "<C-]>", function()
	require("harpoon.ui").nav_file(1)
end, { desc = "Go to Harpoon window 1" })

vim.keymap.set("n", "<C-[>", function()
	require("harpoon.ui").nav_file(2)
end, { desc = "Go to Harpoon window 2" })

vim.keymap.set("n", "<C-p>", function()
	require("harpoon.ui").nav_file(3)
end, { desc = "Go to Harpoon window 3" })

vim.keymap.set("n", "<C-o>", function()
	require("harpoon.ui").nav_file(4)
end, { desc = "Go to Harpoon window 4" })

------------------------------------------------------------------------
------------------------------------------------------------------------

-- Jump to first focusable floating window
function _G.focus_floating_window()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local cfg = vim.api.nvim_win_get_config(win)
		if cfg.focusable and cfg.relative and cfg.relative ~= "" then
			vim.api.nvim_set_current_win(win)
			return
		end
	end
end

vim.keymap.set("n", "<A-f>", _G.focus_floating_window, { desc = "Focus floating window" })
----------------------------------
----------------------------------
----------------------------------
-- Key: Visual mode fix
vim.keymap.set("v", "<leader>cf", function()
	require("CopilotChat").ask("Fix this code", { selection = require("CopilotChat.select").visual })
end, { desc = "Copilot Fix" })

-- Key: Visual mode explain
vim.keymap.set("v", "<leader>ce", function()
	require("CopilotChat").ask("Explain this code", { selection = require("CopilotChat.select").visual })
end, { desc = "Copilot Explain" })

vim.keymap.set("n", "<leader>co", function()
	-- Run the CopilotChat command
	vim.cmd("CopilotChat")
	-- Simulate pressing `i` after a short delay
	vim.defer_fn(function()
		vim.api.nvim_feedkeys("i", "n", false)
	end, 10) -- 10ms delay to ensure the window is ready
end, { noremap = true, silent = true, desc = "Open Copilot Chat and enter insert mode" })
----------------------------------
----------------------------------
----------------------------------
----------------------------------
----------------------------------
-- Define a global to hold the last image filename
vim.g.last_image_filename = vim.g.last_image_filename or "image.png"

vim.api.nvim_create_user_command("PasteImage", function()
	-- Use the last filename as the default
	local default = vim.g.last_image_filename
	local filename = vim.fn.input("Image filename: ", default)
	if filename == "" then
		print("❌ No filename provided.")
		return
	end

	-- Wrap the filename in quotes to handle spaces
	local cmd = 'xclip -selection clipboard -t image/png -o > "' .. filename .. '"'
	local result = vim.fn.system(cmd)

	-- Check if file is actually created and not empty
	local stat = vim.loop.fs_stat(filename)
	if stat and stat.size > 1 then
		-- Save this as the new default
		vim.g.last_image_filename = filename
		print("✅ Image saved as " .. filename)
	else
		print("❌ Failed to save image. Clipboard may not contain an image.")
	end
end, {})
----
----
----
----
--- split window
vim.keymap.set("n", "<leader>wo", function()
	-- Split the window vertically
	vim.cmd("vsplit")

	-- Optional: focus stays on original (left), move cursor back
	vim.cmd("wincmd h")
end, { noremap = true, silent = true, desc = "Vertical split (half screen)" })
------------------------------------
------------------------------------
------------------------------------
------------------------------------
local term_buf_id = nil
local term_win_id = nil

function ToggleBottomTerminal()
	-- determine "target" cwd: use current buffer's dir, else fallback to global cwd
	local bufn = vim.api.nvim_get_current_buf()
	local bufname = vim.api.nvim_buf_get_name(bufn)
	local cwd = ""
	if bufname ~= "" and vim.fn.filereadable(bufname) == 1 then
		cwd = vim.fn.fnamemodify(bufname, ":p:h")
	else
		cwd = vim.fn.getcwd()
	end

	if term_win_id and vim.api.nvim_win_is_valid(term_win_id) then
		-- hide it if already visible
		vim.api.nvim_win_hide(term_win_id)
		term_win_id = nil
	else
		-- if the buffer exists, reuse it; otherwise create a new one
		if term_buf_id and vim.api.nvim_buf_is_valid(term_buf_id) then
			vim.cmd("botright new")
			vim.api.nvim_win_set_height(0, 10)
			vim.api.nvim_win_set_buf(0, term_buf_id)
		else
			vim.cmd("botright new")
			vim.api.nvim_win_set_height(0, 10)
			-- set local cwd of this window to the target dir, only if valid
			if cwd ~= "" and vim.fn.isdirectory(cwd) == 1 then
				vim.cmd("lcd " .. vim.fn.fnameescape(cwd))
			end
			-- spawn a shell
			vim.cmd("term")
			term_buf_id = vim.api.nvim_get_current_buf()
		end

		-- remove any funky background highlights
		vim.api.nvim_win_set_option(0, "winhighlight", "Normal:Normal,NormalNC:Normal")
		vim.cmd("startinsert")

		term_win_id = vim.api.nvim_get_current_win()
	end
end

-- map Alt-- to toggle
vim.api.nvim_set_keymap("n", "<A-->", [[:lua ToggleBottomTerminal()<CR>]], { noremap = true, silent = true })

