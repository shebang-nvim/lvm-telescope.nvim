if not pcall(require, "telescope") then
	return
end

return {
	setup = function(opts)
		require("telescope").setup(opts)

		-- _ = require("telescope").load_extension("projects")
		-- _ = require("telescope").load_extension("dap")
		-- _ = require("telescope").load_extension("notify")
		_ = require("telescope").load_extension("file_browser")
		-- _ = require("telescope").load_extension("ui-select")
		_ = require("telescope").load_extension("fzf")
		-- _ = require("telescope").load_extension("git_worktree")
		-- _ = require("telescope").load_extension("neoclip")

		-- pcall(require("telescope").load_extension, "smart_history")
		pcall(require("telescope").load_extension, "frecency")

		-- pcall(require("telescope").load_extension, "lvm")
		-- pcall(require("telescope").load_extension, "lvm_projects")

		if vim.fn.executable("gh") == 1 then
			pcall(require("telescope").load_extension, "gh")
			pcall(require("telescope").load_extension, "octo")
		end

		-- LOADED_FRECENCY = LOADED_FRECENCY or true
		-- local has_frecency = true
		-- if not LOADED_FRECENCY then
		--   if not pcall(require("telescope").load_extension, "frecency") then
		--     require "tj.telescope.frecency"
		--   end

		--   LOADED_FRECENCY = true
		-- end
	end,
}
