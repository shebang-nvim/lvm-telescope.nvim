return {
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true, enabled = true },
  {
    dir = "~/dev/neovim-plugins/lvm-telescope.nvim",
    -- "shebang-nvim/lvm-telescope.nvim",
    dev = true,
    enabled = true,
    -- priority = 1100, -- make sure to load this before all the other start plugins
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "telescope-fzf-native.nvim" },
        lazy = true,
        cmd = "Telescope",
      },
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "ahmedkhalf/project.nvim",
      "nvim-telescope/telescope-hop.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
      { "nvim-telescope/telescope-frecency.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make", },
      "nvim-telescope/telescope-dap.nvim",
      "folke/which-key.nvim",
      {
        "ahmedkhalf/project.nvim",
        dependencies = { "kkharji/sqlite.lua" },
        opts = {
          show_hidden = false,
        },
        -- config = function(_, opts)
        --   require("telescope").load_extension "projects"
        --   require("project_nvim").setup(opts)
        -- end,
      },
      "nvim-telescope/telescope.nvim",
      {
        "AckslD/nvim-neoclip.lua",
        -- config = function()
        --   require("neoclip").setup()
        -- end,
      },
    },
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      { "<space>wt" },
      { "<space>/" },
      { "<space>en" },
      { "<leader>uC" },
      { "<space>bo" },
      { "<space>fh" },
      { "<space>ff" },
      { "<leader>sd" },
      { "<space>fi" },
      { "<leader>'" },
      { "<leader>:" },
      { "<space>fp" },
      { "<leader>," },
      { "<space>gc" },
      { "<space>gs" },
      { "<space>fe" },
      { "<space>fv" },
      { "<leader>sM" },
      { "<leader>sR" },
      { "<space>pp" },
      { "<space>pP" },
      { "<space>fs" },
      { "<space>fd" },
      { "<space>fO" },
      { ",fo" },
      { "<space>fo" },
      { "<space>fg" },
      { "<leader>/" },
      { "<space>ft" },
      { "<space><space>d" },
      { "<leader>dd" },
      { "gl" },
      { "<space>ez" },
      { "<leader>;" },
      { "<space>f/" },
      { "<leader>fr" },
      { "gw" },
      { "<space>fb" },
      { "<space>fa" },
      { "<space>gp" },
      { "<space>fB" },
      { "<leader>sK" },
    },
    event = { "BufReadPost", "BufNewFile" },
    --
    opts = {
      module = {
        keymaps = {
          {
            "<space>ez",
            "edit_project_files",
            desc = "Edit zsh config",
            picker_opts = {
              shorten_path = false,
              cwd = "~/.config/zsh/",
              prompt = "~ zsh config ~",
              hidden = true,

              layout_strategy = "horizontal",
              layout_config = {
                preview_width = 0.55,
              },

            },
          },
          {
            "<space>en",
            "edit_project_files",
            desc = "Edit Neovim Config (lvim)",
            picker_opts = {
              prompt_title = "Neovim config",
              shorten_path = false,
              cwd = "~/.config/lvim",
            },
          },
        },
      },
      which_key = {
        mode = { "n", "v" },
        ["<Space>"] = { name = "+Telescope" },
        ["<Space>e"] = { name = "+edit files" },
        ["<Space>f"] = { name = "+files and find" },
        ["<Space>g"] = { name = "+git" },
        ["<Space>p"] = { name = "+projects" },
        ["<Space>b"] = { name = "+options" },
        ["<Space>w"] = { name = "+treesitter" },
      },
    },
    config = function(_, opts)
      local log = require 'plenary.log'
      log.info("calling lvm.telescope.setup()")
      require("lvm.telescope").setup(opts)

      local wk = require "which-key"
      wk.register(opts.which_key)
    end,
  }

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
