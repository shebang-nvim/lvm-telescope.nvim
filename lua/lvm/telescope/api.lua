local TelescopeApi = {}

local utils = require("telescope.utils")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local themes = require("telescope.themes")

local set_prompt_to_entry_value = function(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  if not entry or not type(entry) == "table" then
    return
  end

  action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

local _ = pcall(require, "nvim-nonicons")

function TelescopeApi.edit_project_files(opts)
  local opts_with_preview, opts_without_preview

  opts_with_preview = {
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = "flex",
    layout_config = {
      width = 0.9,
      height = 0.8,

      horizontal = {
        width = { padding = 0.15 },
      },
      vertical = {
        preview_height = 0.75,
      },
    },

    mappings = {
      i = {
        ["<C-y>"] = false,
      },
    },

    attach_mappings = function(_, map)
      map("i", "<c-y>", set_prompt_to_entry_value)
      map("i", "<M-c>", function(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.schedule(function()
          require("telescope.builtin").find_files(opts_without_preview)
        end)
      end)

      return true
    end,
  }

  opts_with_preview = vim.tbl_deep_extend('force', opts_with_preview, opts or {})
  opts_without_preview = vim.deepcopy(opts_with_preview)
  opts_without_preview.previewer = false

  require("telescope.builtin").find_files(opts_with_preview)
end

function TelescopeApi.colorscheme(opts)
  require("telescope.builtin").colorscheme(vim.tbl_extend("force", opts, {
    enable_preview = true,
  }))
end

function TelescopeApi.find_nvim_source()
  require("telescope.builtin").find_files({
    prompt_title = "~ nvim ~",
    shorten_path = false,
    cwd = "~/build/neovim/",

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.35,
    },
  })
end

-- function TelescopeApi.sourcegraph_find()
-- 	require("telescope.builtin").find_files({
-- 		prompt_title = "~ sourcegraph ~",
-- 		shorten_path = false,
-- 		cwd = "~/sourcegraph/",
--
-- 		layout_strategy = "horizontal",
-- 		layout_config = {
-- 			width = 0.25,
-- 			preview_width = 0.65,
-- 		},
-- 	})
-- end

-- function TelescopeApi.sourcegraph_main_find()
-- 	require("telescope.builtin").find_files({
-- 		prompt_title = "~ main: sourcegraph ~",
-- 		shorten_path = false,
-- 		cwd = "~/sourcegraph/sourcegraph.git/main/",
--
-- 		layout_strategy = "horizontal",
-- 		layout_config = {
-- 			width = 0.95,
-- 			preview_width = 0.65,
-- 		},
-- 	})
-- end

-- function TelescopeApi.sourcegraph_about_find()
-- 	require("telescope.builtin").find_files({
-- 		prompt_tiles = [[\ Sourcegraph About: Files /]],
-- 		cwd = "~/sourcegraph/about/handbook/",
--
-- 		sorter = require("telescope").extensions.fzy_native.native_fzy_sorter(),
-- 	})
-- end
--
-- function TelescopeApi.sourcegraph_about_grep()
-- 	require("telescope.builtin").live_grep({
-- 		prompt_tiles = [[\ Sourcegraph About: Files /]],
-- 		cwd = "~/sourcegraph/about/",
--
-- 		-- sorter = require('telescope').extensions.fzy_native.native_fzy_sorter(),
-- 	})
-- end

-- TODO: Should work on a wiki at some point....
--function TelescopeApi.sourcegraph_tips()
--  -- TODO: Can make this optionally fuzzy find over the contents as well
--  --    if we want to start getting fancier
--  --
--  --    Could even make it do that _only_ when doing something like ";" or similar.

--  require('telescope.builtin').find_files {
--    prompt_title = "~ sourcegraph ~",
--    shorten_path = false,
--    cwd = "~/wiki/sourcegraph/tips",
--    width = .25,

--    layout_strategy = 'horizontal',
--    layout_config = {
--      preview_width = 0.65,
--    },
--  }
--end

function TelescopeApi.edit_zsh()
  require("telescope.builtin").find_files({
    shorten_path = false,
    cwd = "~/.config/zsh/",
    prompt = "~ dotfiles ~",
    hidden = true,

    layout_strategy = "horizontal",
    layout_config = {
      preview_width = 0.55,
    },
  })
end

function TelescopeApi.find_files()
  -- local opts = themes.get_ivy {
  --   hidden = false,
  --   sorting_strategy = "ascending",
  --   layout_config = { height = 9 },
  -- }
  require("telescope.builtin").find_files({
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    layout_config = {
      -- height = 10,
    },
  })
end

function TelescopeApi.fs()
  local opts = themes.get_ivy({ hidden = false, sorting_strategy = "descending" })
  require("telescope.builtin").find_files(opts)
end

function TelescopeApi.builtin()
  require("telescope.builtin").builtin()
end

function TelescopeApi.git_files()
  local path = vim.fn.expand("%:h")
  if path == "" then
    path = nil
  end

  local width = 0.75
  if path and string.find(path, "sourcegraph.*sourcegraph", 1, false) then
    width = 0.5
  end

  local opts = themes.get_dropdown({
    winblend = 5,
    previewer = false,
    shorten_path = false,

    cwd = path,

    layout_config = {
      width = width,
    },
  })

  require("telescope.builtin").git_files(opts)
end

function TelescopeApi.buffer_git_files()
  require("telescope.builtin").git_files(themes.get_dropdown({
    cwd = vim.fn.expand("%:p:h"),
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  }))
end

function TelescopeApi.lsp_code_actions()
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })

  require("telescope.builtin").lsp_code_actions(opts)
end

function TelescopeApi.live_grep(opts)
  require("telescope.builtin").live_grep(vim.tbl_deep_extend("force", themes.get_ivy(opts), {
    -- shorten_path = true,
    previewer = true,
    fzf_separator = "|>",
  }))
end
function TelescopeApi.live_grep_continue(opts)
  require("telescope.builtin").live_grep(vim.tbl_deep_extend("force", themes.get_ivy(opts), {
    -- shorten_path = true,
    previewer = true,
    fzf_separator = "|>",
  }))
end

function TelescopeApi.lsp_document_symbols(opts)
  require("telescope.builtin").lsp_document_symbols(vim.tbl_deep_extend("force", opts, {
    -- shorten_path = true,
    previewer = true,
  }))
end

function TelescopeApi.grep_prompt()
  require("telescope.builtin").grep_string({
    path_display = { "shorten" },
    search = vim.fn.input("Grep String > "),
  })
end

function TelescopeApi.grep_last_search(opts)
  opts = opts or {}

  -- \<getreg\>\C
  -- -> Subs out the search things
  local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

  opts.path_display = { "shorten" }
  opts.word_match = "-w"
  opts.search = register

  require("telescope.builtin").grep_string(opts)
end

function TelescopeApi.oldfiles_frecency(opts)
  require("telescope").extensions.frecency.frecency(themes.get_ivy(vim.tbl_extend("force", {
    path_display = { "truncate" },
    previewer = false,
  }, opts)))
end

function TelescopeApi.oldfiles(opts)
  require("telescope.builtin").oldfiles(vim.tbl_extend("force", {
    layout_strategy = 'vertical',
    layout_config = { height = 0.9, width = 0.7, preview_height = 0.5, scroll_speed = 10 },

    path_display = { "truncate" },
    previewer = false,
  }, opts))
end

function TelescopeApi.my_plugins()
  require("telescope.builtin").find_files({
    cwd = "~/plugins/",
  })
end

function TelescopeApi.installed_plugins()
  require("telescope.builtin").find_files({
    cwd = vim.fn.stdpath("data") .. "/lazy/",
  })
end

function TelescopeApi.project_search(opts)
  require("telescope").extensions.projects.projects({})
end

function TelescopeApi.project_search_lvm(opts)
  require("telescope").extensions.lvm_projects.projects()
end

function TelescopeApi.project_search_simple()
  require("telescope.builtin").find_files({
    previewer = false,
    layout_strategy = "vertical",
    cwd = require("lspconfig.util").root_pattern(".git")(vim.fn.expand("%:p")),
  })
end

function TelescopeApi.buffers()
  require("telescope.builtin").buffers({
    shorten_path = false,
  })
end

function TelescopeApi.curbuf()
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function TelescopeApi.help_tags()
  require("telescope.builtin").help_tags({
    show_version = true,
  })
end

function TelescopeApi.search_all_files()
  require("telescope.builtin").find_files({
    find_command = { "rg", "--no-ignore", "--files" },
  })
end

function TelescopeApi.example_for_prime()
  -- local Sorter = require('telescope.sorters')

  -- require('telescope.builtin').find_files {
  --   sorter = Sorter:new {
  -- }
end

function TelescopeApi.file_browser()
  local opts

  opts = {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    layout_config = {
      prompt_position = "top",
    },

    attach_mappings = function(prompt_bufnr, map)
      local current_picker = action_state.get_current_picker(prompt_bufnr)

      local modify_cwd = function(new_cwd)
        local finder = current_picker.finder

        finder.path = new_cwd
        finder.files = true
        current_picker:refresh(false, { reset_prompt = true })
      end

      map("i", "-", function()
        modify_cwd(current_picker.cwd .. "/..")
      end)

      map("i", "~", function()
        modify_cwd(vim.fn.expand("~"))
      end)

      -- local modify_depth = function(mod)
      --   return function()
      --     opts.depth = opts.depth + mod
      --
      --     current_picker:refresh(false, { reset_prompt = true })
      --   end
      -- end
      --
      -- map("i", "<M-=>", modify_depth(1))
      -- map("i", "<M-+>", modify_depth(-1))

      map("n", "yy", function()
        local entry = action_state.get_selected_entry()
        vim.fn.setreg("+", entry.value)
      end)

      return true
    end,
  }

  require("telescope").extensions.file_browser.file_browser(opts)
end

function TelescopeApi.git_status()
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })

  -- Can change the git icons using this.
  -- opts.git_icons = {
  --   changed = "M"
  -- }

  require("telescope.builtin").git_status(opts)
end

function TelescopeApi.git_commits()
  require("telescope.builtin").git_commits({
    winblend = 5,
  })
end

function TelescopeApi.search_only_certain_files()
  require("telescope.builtin").find_files({
    find_command = {
      "rg",
      "--files",
      "--type",
      vim.fn.input("Type: "),
    },
  })
end

function TelescopeApi.lsp_references()
  require("telescope.builtin").lsp_references({
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  })
end

function TelescopeApi.lsp_implementations()
  require("telescope.builtin").lsp_implementations({
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  })
end

function TelescopeApi.vim_options()
  require("telescope.builtin").vim_options({
    layout_config = {
      width = 0.5,
    },
    sorting_strategy = "ascending",
  })
end

return setmetatable({}, {
  __index = function(_, k)
    -- reloader()

    local has_custom, custom = pcall(require, string.format("lvm.telescope.custom.%s", k))

    if TelescopeApi[k] then
      return TelescopeApi[k]
    elseif has_custom then
      return custom
    else
      return require("telescope.builtin")[k]
    end
  end,
})
