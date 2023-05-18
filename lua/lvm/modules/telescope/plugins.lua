return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		-- lazy = false,
		version = false, -- telescope did only one release, so use HEAD for now
	},
	-- {
	-- 	"nvim-telescope/telescope-dap.nvim",
	-- 	dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
	-- },
	-- {
	-- 	"nvim-telescope/telescope-file-browser.nvim",
	-- 	lazy = false,
	-- 	-- dependencies = { "nvim-telescope/telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("file_browser")
	-- 	end,
	-- },
	-- { "nvim-telescope/telescope-symbols.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	-- {
	-- 	"ahmedkhalf/project.nvim",
	-- 	-- dependencies = { "nvim-telescope/telescope.nvim" },
	-- 	opts = {
	-- 		show_hidden = false,
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("telescope").load_extension("project")
	-- 		require("project_nvim").setup(opts)
	-- 	end,
	-- },
	-- {
	-- 	-- dir = "~/dev/neovim-plugins/telescope-lvm.nvim",
	-- 	"shebang/telescope-lvm.nvim",
	-- 	config = function() end,
	-- 	dev = true,
	-- },
	-- { "nvim-telescope/telescope-frecency.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	-- "nvim-telescope/telescope-hop.nvim",
	-- { "nvim-telescope/telescope-snippets.nvim", dependencies = "nvim-telescope/telescope.nvim" },
	--  "nvim-telescope/telescope-smart-history.nvim",
	-- "nvim-telescope/telescope-github.nvim",
	-- { "nvim-telescope/telescope-ui-select.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
	-- "nvim-telescope/telescope-live-grep-args.nvim",
	-- "nvim-telescope/telescope-media-files.nvim",
	-- "ghassan0/telescope-glyph.nvim",
	-- "cljoly/telescope-repo.nvim",
	-- "kkharji/sqlite.lua",
	-- {
	-- 	"nvim-telescope/telescope-fzf-native.nvim",
	-- 	build = "make",
	-- 	dependencies = { "nvim-telescope/telescope.nvim" },
	-- },
	-- {
	-- 	"ThePrimeagen/git-worktree.nvim",
	-- 	config = function()
	-- 		require("git-worktree").setup({})
	-- 	end,
	-- },
	-- {
	-- 	"AckslD/nvim-neoclip.lua",
	-- 	config = function()
	-- 		require("neoclip").setup()
	-- 	end,
	-- },
}
