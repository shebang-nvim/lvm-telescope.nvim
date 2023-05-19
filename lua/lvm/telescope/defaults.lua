local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local action_layout = require "telescope.actions.layout"


local defaults = {}

defaults.module = {
  lazy = false,
  keymaps = {
    { "<leader>,",  "buffers",           desc = "Switch Buffer" },
    { "<leader>/",  "search_history",    desc = "Show Search History" },
    { "<leader>:",  "command_history",   desc = "Show Command History" },
    { "<leader>'",  "registers",         desc = "Show Registers" },
    { "<leader>;",  "oldfiles_frecency", desc = "Show Recent Files (frecency)" },
    { "<leader>fr", "oldfiles",          desc = "Show Recent Files" },
    { "<leader>sd", "diagnostics",       desc = "Show Document Diagnostics" },
    { "<leader>dd", "diagnostics",       desc = "Show Document Diagnostics" },
    { "<leader>sK", "keymaps",           desc = "Show Keymaps" },
    { "<leader>sM", "man_pages",         desc = "Show Man Pages" },
    { "<leader>sR", "resume",            desc = "Resume" },
    { "<leader>uC", "colorscheme",       desc = "Show Colorschemes" },
    {
      "<space>/",
      "multi_rg",
      desc = "Live grep (home dir)",
      picker_opts = {
        cwd = vim.fn.expand("~/dev"),
        short_path = true,
        layout_config = {
          width = 0.99,
          height = 0.97,
        },
      },
    },
    { "<space><space>d", "diagnostics",           desc = "Show LSP diagnostics" },
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
          -- preview_width = 0.65,
          width = 0.85,
        },

      },
    },
    {
      "<space>en",
      "edit_project_files",
      desc = "Edit neovim config",
      picker_opts = {
        prompt_title = "Neovim config",
        shorten_path = false,
        cwd = "~/.config/nvim",

        layout_strategy = "horizontal",
        layout_config = {
          -- preview_width = 0.65,
          width = 0.85,
        },
      },
    },
    {
      "<Space>,",
      "live_grep",
      desc = "Live grep current project",
    },
    {
      "<Space><",
      "live_grep_continue",
      desc = "Live grep continue",
    },
{
      "gl",
      "live_grep",
      desc = "Live grep current project",
    },
    {
      "gw",
      "grep_string",
      desc = "Grep string",
      picker_opts = {
        word_match = "-w",
        short_path = true,
        only_sort_text = true,
        layout_strategy = "vertical",
      },
    },
    {
      "<space>f/",
      "grep_last_search",
      desc = "Grep last search",
      picker_opts = {
        layout_strategy = "vertical",
      },
    },

    { "<space>d",       "lsp_document_symbols",             desc = "LSP Document Sumbols" },
    { "<space>ft",       "git_files",             desc = "Git files" },
    { "<space>fg",       "multi_rg",              desc = "Multi Ripgrep" },
    { "<space>fo",       "oldfiles_frecency",     desc = "Oldfiles using frecency" },
    { ",fo",             "oldfiles_frecency",     desc = "Oldfiles using frecency" },
    { "<space>fO",       "oldfiles",              desc = "Oldfiles" },
    { "<space>fd",       "find_files",            desc = "Find files" },
    { "<space>fs",       "fs",                    desc = "fs" },
    { "<space>pP",       "project_search_simple", desc = "Search in recent projects" },
    { "<space>pp",       "project_search",        desc = "Search in recent projects using extension" },
    { "<space>fv",       "find_nvim_source",      desc = "Find in neovim source" },
    { "<space>fe",       "file_browser",          desc = "Show file browser" },
    { "<space>gs",       "git_status",            desc = "Show GIT status" },
    { "<space>gc",       "git_commits",           desc = "Show GIT commits" },
    { "<space>fb",       "buffers",               desc = "Show buffer list" },
    { "<space>fp",       "my_plugins",            desc = "Search in my plugins" },
    { "<space>fa",       "installed_plugins",     desc = "Show installed plugins" },
    { "<space>fi",       "search_all_files",      desc = "Search in all files" },
    { "<space>ff",       "curbuf",                desc = "Search in current buffer" },
    { "<space>fh",       "help_tags",             desc = "Show help tags" },
    { "<space>bo",       "vim_options",           desc = "Show vim options" },
    { "<space>gp",       "grep_prompt",           desc = "Show grep prompt" },
    { "<space>wt",       "treesitter",            desc = "Show treesitter" },
    { "<space>fB",       "builtin",               desc = "Show builtin commands" },
  },
}

defaults.telescope = {
  defaults = {
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    multi_icon = "<>",

    path_display = {
      truncate = 3
    },
    -- path_display = "tail",

    winblend = 0,

    layout_strategy = "horizontal",
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = "top",

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    color_devicons = true,

    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,
        ["<C-e>"] = actions.results_scrolling_down,
        ["<C-y>"] = actions.results_scrolling_up,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-/>"] = actions.which_key,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        ["<C-w>"] = { "<c-s-w>", type = "command" },

        ["<M-p>"] = action_layout.toggle_preview,
        ["<M-m>"] = action_layout.toggle_mirror,
        ["<M-w>"] = actions.which_key,

        -- disable c-j because we dont want to allow new lines #2123
        -- ["<C-j>"] = actions.nop,

        ["<C-k>"] = actions.cycle_history_next,
        ["<C-j>"] = actions.cycle_history_prev,
        ["<c-g>s"] = actions.select_all,
        ["<c-g>a"] = actions.add_selection,

      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        -- TODO: This would be weird if we switch the ordering.
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },

      -- ["<C-w>"] = function()
      --   vim.api.nvim_input "<c-s-w>"
      -- end,

      -- i = {
      --   ["<RightMouse>"] = actions.close,
      --   ["<LeftMouse>"] = actions.select_default,
      --   ["<ScrollWheelDown>"] = actions.move_selection_next,
      --   ["<ScrollWheelUp>"] = actions.move_selection_previous,
      --
      --   ["<C-x>"] = false,
      --   ["<C-s>"] = actions.select_horizontal,
      --   ["<C-n>"] = "move_selection_next",
      --
      --   ["<C-e>"] = actions.results_scrolling_down,
      --   ["<C-y>"] = actions.results_scrolling_up,
      --   -- ["<C-y>"] = set_prompt_to_entry_value,
      --
      --   -- These are new :)
      --   ["<M-p>"] = action_layout.toggle_preview,
      --   ["<M-m>"] = action_layout.toggle_mirror,
      --   -- ["<M-p>"] = action_layout.toggle_prompt_position,
      --
      --   -- ["<M-m>"] = actions.master_stack,
      --
      --   -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
      --   -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      --
      --   -- This is nicer when used with smart-history plugin.
      --   ["<C-k>"] = actions.cycle_history_next,
      --   ["<C-j>"] = actions.cycle_history_prev,
      --   ["<c-g>s"] = actions.select_all,
      --   ["<c-g>a"] = actions.add_selection,
      --
      --   -- ["<c-space>"] = function(prompt_bufnr)
      --   --   local opts = {
      --   --     callback = actions.toggle_selection,
      --   --     loop_callback = actions.send_selected_to_qflist,
      --   --   }
      --   --   require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
      --   -- end,
      --
      --   ["<C-w>"] = function()
      --     vim.api.nvim_input "<c-s-w>"
      --   end,
      -- },
      --
      -- n = {
      --   ["<C-e>"] = actions.results_scrolling_down,
      --   ["<C-y>"] = actions.results_scrolling_up,
      -- },
    },

    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    -- file_ignore_patterns = nil,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    history = {
      path = "~/.local/share/nvim/databases/telescope_history.sqlite3",
      limit = 100,
    },
  },

  pickers = {
    find_files = {
      -- I don't like having the cwd prefix in my files
      find_command = { "fdfind", "--strip-cwd-prefix", "--type", "f" },

      mappings = {
        n = {
          ["kj"] = "close",
        },
      },
    },

    git_branches = {
      mappings = {
        i = {
          ["<C-a>"] = false,
        },
      },
    },

    buffers = {
      sort_lastused = true,
      sort_mru = true,
    },
  },

  extensions = {
    ---
    ---@class TelescopeConfigLvmQueryTools
    ---
    ['query-tools'] = {
      -- What scope to change the directory, valid options are
      -- * global (default)
      -- * tab
      -- * win
      scope_chdir = "win",

      quiet = false,
      -- Show hidden files in telescope
      show_hidden = true,

      -- When set to false, you will get a message when project.nvim changes your
      -- directory.
      silent_chdir = false,


      theme = "ivy",

      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },

    },

    ---
    ---@class TelescopeConfigLvm
    ---
    lvm = {
      theme = "ivy",

      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },

    ---
    ---@class TelescopeConfigLvmProjects
    ---
    lvm_projects = {

      scope_chdir = "win",
    },

    ---
    ---@class TelescopeConfigFzyNative
    ---
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },

    ---
    ---
    ---@class TelescopeConfigFzfWriter
    ---

    fzf_writer = {
      use_highlighter = false,
      minimum_grep_characters = 6,
    },

    ---
    ---
    ---@class TelescopeConfigHop
    ---
    hop = {
      -- keys define your hop keys in order; defaults to roughly lower- and uppercased home row
      keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";" }, -- ... and more

      -- Highlight groups to link to signs and lines; the below configuration refers to demo
      -- sign_hl typically only defines foreground to possibly be combined with line_hl
      sign_hl = { "WarningMsg", "Title" },

      -- optional, typically a table of two highlight groups that are alternated between
      line_hl = { "CursorLine", "Normal" },

      -- options specific to `hop_loop`
      -- true temporarily disables Telescope selection highlighting
      clear_selection_hl = false,
      -- highlight hopped to entry with telescope selection highlight
      -- note: mutually exclusive with `clear_selection_hl`
      trace_entry = true,
      -- jump to entry where hoop loop was started from
      reset_selection = true,
    },

    ---
    ---
    ---@class TelescopeConfigUiSelect
    ---
    ["ui-select"] = {
      require("telescope.themes").get_dropdown({
        -- even more opts
      }),
    },

    ---
    ---
    ---@class TelescopeConfigFrecency
    ---
    frecency = {
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = { "*.git/*", "*/tmp/*" },
      workspaces = {
        ["nvim"] = vim.fn.expand("~/.config/nvim"),
        ["lvim"] = vim.fn.expand("~/.config/lvim"),
        ["tj"] = vim.fn.expand("~/dev/repos/github.com/tjdevries"),
        ["folke"] = vim.fn.expand("~/dev/repos/github.com/folke"),
        ["lunar"] = vim.fn.expand("~/dev/neovim-plugins/LunarVim"),
        ["zsh"] = vim.fn.expand("~/.config/zsh"),
        ["doc"] = vim.fn.expand("~/dev/doc"),
      },
    },
  },
}

return defaults
