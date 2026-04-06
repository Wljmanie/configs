return {
	"ThePrimeagen/harpoon",
	keys = {
		-- Add file to Harpoon
		{
			"<C-a>",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Add file to Harpoon",
		},
		-- Toggle Harpoon menu
		{
			"<C-h>",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Toggle Harpoon menu",
		},
		-- Jump to specific Harpoon files (1-4 as example)
		{
			"<C-1>",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "Go to Harpoon file 1",
		},
		{
			"<C-2>",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "Go to Harpoon file 2",
		},
		{
			"<C-3>",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "Go to Harpoon file 3",
		},
		{
			"<C-4>",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "Go to Harpoon file 4",
		},
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")

		-- Optional: repeat keymaps in config if you want direct Vim API mapping
		vim.keymap.set("n", "<C-a>", mark.add_file, { desc = "Add file to Harpoon" })
		vim.keymap.set("n", "<C-h>", ui.toggle_quick_menu, { desc = "Harpoon Menu" })
		vim.keymap.set("n", "<C-1>", function()
			ui.nav_file(1)
		end, { desc = "Go to Harpoon file 1" })
		vim.keymap.set("n", "<C-2>", function()
			ui.nav_file(2)
		end, { desc = "Go to Harpoon file 2" })
		vim.keymap.set("n", "<C-3>", function()
			ui.nav_file(3)
		end, { desc = "Go to Harpoon file 3" })
		vim.keymap.set("n", "<C-4>", function()
			ui.nav_file(4)
		end, { desc = "Go to Harpoon file 4" })
	end,
}
