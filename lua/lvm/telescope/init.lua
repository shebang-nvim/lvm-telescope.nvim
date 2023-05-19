--- *lvm.telescope* Telescope Configuration
--- *LvmTelescope*
---
--- MIT License Copyright (c) 2023 SHBorg
---
--- ==============================================================================
---
--- CREDITS:
---   * TJ Devries' Telescope config: https://github.com/tjdevries/config_manager/tree/master/xdg_config/nvim/lua/tj/telescope
---   * Evgeni Chasnovski's awesome mini.nvim libraries: https://github.com/echasnovski/mini.nvim/tree/main/lua/mini
---
--- Features:
---
--- TODO
---
---
local LvmTelescope = {}
local utils = require("lvm.telescope.utils")
local conf = require("lvm.telescope.config")
local log = require("lvm.telescope.log")

local H = {}
LvmTelescope.map_tele = require("lvm.telescope.mappings")

LvmTelescope.setup = function(config)
  -- Setup config
  -- config = H.setup_config(config)

  conf.config = config

  -- Apply config
  H.apply_config(conf.config)

  -- Export module
  _G.LvmTelescope = LvmTelescope

  return LvmTelescope
end
--- Module config
---
LvmTelescope.config = {}
--minidoc_afterlines_end

-- Helper data ================================================================
-- Module default config
H.default_config = require("lvm.telescope.config").defaults

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
H.setup_config = function(config)
  -- config = config or {}
  -- config.module = config.module or {}
  -- config.module.keymaps = config.module.keymaps or {}
  -- config.module.lazy_keys = {}
  --
  -- local default_keymaps = utils.build_lazy_keys(H.default_config.module.keymaps)
  --
  -- if not vim.tbl_isempty(config.module.keymaps) then
  --   config.module.lazy_keys = utils.build_lazy_keys(config.module.keymaps)
  -- end
  --
  -- config.module.lazy_keys = vim.tbl_deep_extend("force", default_keymaps, config.module.lazy_keys)
  -- config.telescope = vim.tbl_deep_extend("force", H.default_config.telescope, config.telescope or {})
  -- return config
end

LvmTelescope.lazy_keys = function()
  return vim.tbl_keys(LvmTelescope.config.module.lazy_keys)
end

H.apply_config = function(config)
  local Keys = require("lazy.core.handler.keys")
  -- local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>
  require("lvm.telescope.setup").setup(config)
  for _, keys in pairs(config.module.lazy_keys) do
    if not keys.has then
      local opts = Keys.opts(keys)
      ---@diagnostic disable-next-line: no-unknown
      local picker_opts = {}
      opts.has = nil
      opts.silent = opts.silent ~= false
      if opts.picker_opts then
        picker_opts = opts.picker_opts
        opts.picker_opts = nil
      end
      picker_opts.keymap = opts

      log.debug(string.format("mapping key: lhs=%s desc=%s", keys[1], vim.inspect(picker_opts):gsub("\n", ""):gsub("%s+", " ")))
      LvmTelescope.map_tele(keys[1], keys[2], picker_opts)
    end
  end

  LvmTelescope.config = config
end


return LvmTelescope
