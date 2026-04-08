return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- LLDB adapter for Arch
			dap.adapters.lldb = {
				type = "executable",
				command = "/usr/bin/lldb-dap", -- fixed: use lldb directly
				name = "lldb",
			}

			-- C/C++ configurations with out/ recursive search
			dap.configurations.cpp = {
				{
					name = "Launch CMake target",
					type = "lldb",
					request = "launch",
					program = function()
						local cwd = vim.fn.getcwd()
						local out_dir = cwd .. "/out/Debug"
						local executables = {}
						local handle = io.popen('find "' .. out_dir .. '" -type f -executable')
						if handle then
							for line in handle:lines() do
								table.insert(executables, line)
							end
							handle:close()
						end

						if #executables == 0 then
							return vim.fn.input("Path to executable: ", out_dir .. "/", "file")
						elseif #executables == 1 then
							return executables[1]
						else
							print("Multiple executables found:")
							for i, f in ipairs(executables) do
								print(i .. ": " .. f)
							end
							local choice = tonumber(vim.fn.input("Choose executable number: "))
							return executables[choice]
						end
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}

			dap.configurations.c = dap.configurations.cpp

			-- Setup dap-ui
			dapui.setup()
			require("nvim-dap-virtual-text").setup()

			-- Keybindings
			local opts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap(
				"n",
				"<F1>",
				[[<cmd>lua vim.cmd("!cmake --build out --config Debug -j$(nproc)") require('dap').continue() <CR>]],
				opts
			)
			vim.api.nvim_set_keymap(
				"n",
				"<F7>",
				[[<cmd>lua vim.cmd("!cmake --build out --config Release -j$(nproc)") <CR>]],
				opts
			)
			vim.api.nvim_set_keymap("n", "<F2>", '<cmd>lua require"dap".continue()<CR>', opts)
			vim.api.nvim_set_keymap("n", "<F3>", '<cmd>lua require"dap".step_into()<CR>', opts)
			vim.api.nvim_set_keymap("n", "<F4>", '<cmd>lua require"dap".step_over()<CR>', opts)
			vim.api.nvim_set_keymap("n", "<F5>", '<cmd>lua require"dap".step_out()<CR>', opts)

			vim.api.nvim_set_keymap("n", "<leader>b", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>B",
				'<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
				opts
			)
			vim.api.nvim_set_keymap("n", "<leader>du", '<cmd>lua require"dapui".toggle()<CR>', opts)
			vim.api.nvim_set_keymap("n", "<leader>dr", '<cmd>lua require"dap".repl.open()<CR>', opts)
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
	},
}
