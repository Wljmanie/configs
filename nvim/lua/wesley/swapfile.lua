local function toggle_header_source()
	local filename = vim.fn.expand("%:t:r") -- filename without extension
	local dirpath = vim.fn.expand("%:h") -- current file directory
	local ext = vim.fn.expand("%:e") -- file extension

	local function file_exists(path)
		return vim.fn.filereadable(path) == 1
	end

	local function src_to_inc()
		local try_h = dirpath:gsub("/src/", "/include/") .. "/" .. filename .. ".h"
		local try_hpp = dirpath:gsub("/src/", "/include/") .. "/" .. filename .. ".hpp"
		if file_exists(try_h) then
			return try_h
		end
		if file_exists(try_hpp) then
			return try_hpp
		end
		return nil
	end

	local function inc_to_src()
		local try_cpp = dirpath:gsub("/include/", "/src/") .. "/" .. filename .. ".cpp"
		local try_c = dirpath:gsub("/include/", "/src/") .. "/" .. filename .. ".c"
		if file_exists(try_cpp) then
			return try_cpp
		end
		if file_exists(try_c) then
			return try_c
		end
		return nil
	end

	local target_file = nil
	if ext == "cpp" or ext == "c" then
		target_file = src_to_inc()
	elseif ext == "h" or ext == "hpp" then
		target_file = inc_to_src()
	end

	if target_file then
		vim.cmd("edit " .. target_file)

		-- Ensure LSP is attached
		local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
		if not clients or vim.tbl_isempty(clients) then
			vim.cmd("silent! LspStart")
		end
	else
		print("No matching header/source found!")
	end
end

vim.keymap.set("n", "<leader>o", toggle_header_source, { noremap = true, silent = true })
