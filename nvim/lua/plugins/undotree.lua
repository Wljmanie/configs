return {
	"mbbill/undotree",
	cmd = "UndotreeToggle", -- lazy-load when you open the undotree
	keys = {
		{ "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" }, -- optional keybinding
	},
	config = function()
		-- Optional: open Undotree on startup of a file
		vim.g.undotree_WindowLayout = 2 -- vertical split
		vim.g.undotree_SplitWidth = 35 -- width of the undotree window
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
