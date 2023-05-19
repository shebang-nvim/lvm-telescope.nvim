local store = {}
local utils = require("lvm.telescope.utils")
local log = require("lvm.telescope.log")


local _defaults_basic
local function load_basic_defaults()
  if _defaults_basic then -- result available?
    return _defaults_basic
  else
    _defaults_basic = require 'lvm.telescope.defaults'
    return _defaults_basic
  end
end

local function build_defaults()
  local mod_table = {
    actions = 'actions',
    action_layout = 'actions.layout'
  }
  local function build(t)
    for key, value in pairs(t) do
      if type(value) == 'string' then
        local mod, f = unpack(vim.split(value, '.', true))

        local r_mod = mod_table[mod]
        if r_mod then
          t[key] = require('telescope.' .. r_mod)[f]
        else
          log.debug(string.format("error loading module: mod=%s r_mod=%s ", mod, r_mod))
        end
      end
    end
    return t
  end

  local c = vim.deepcopy(load_basic_defaults())
  c.telescope.defaults.mappings.i = build(c.telescope.defaults.mappings.i)
  c.telescope.defaults.mappings.n = build(c.telescope.defaults.mappings.n)

  c.module.lazy_keys = utils.build_lazy_keys(c.module.keymaps)
  return c
end


local defaults
local function load_defaults()
  if defaults then -- result available?
    return defaults
  else
    defaults = build_defaults()
    return defaults
  end
end
---Set config as current config.
---The config table is written to a global storage table
---@param config LvmTelescopeConfig
local function config_setter(config)

  --- 1 build defaults
  ---
  local defaults = load_defaults()

  --- 2 merge with user supplied config
  ---
  config = vim.tbl_deep_extend('force', defaults, config or {})


  --- 3 build lazy_keys and merge wih defaults
  ---
  if not vim.tbl_isempty(config.module.keymaps) then
    config.module.lazy_keys = utils.build_lazy_keys(config.module.keymaps)
    config.module.lazy_keys = vim.tbl_deep_extend('force', defaults.module.lazy_keys, config.module.lazy_keys or {})
  end

  log.debug("new config generated, config follows")
  log.debug( config)
  return config
end

---Returns the current running config
---@return LvmTelescopeConfig
local function config_getter()
  ---@type LvmTelescopeConfig
  return store.config or {}
end

local t = {}
-- create metatable
local mt = {
  __index = function(t, k)
    -- print("*access to element " .. tostring(k))

    if k == 'config' then
      return config_getter()
    end
  end,

  __newindex = function(t, k, v)
    if k == 'config' then
      store.config = config_setter(v)
    end
  end
}
setmetatable(t, mt)


return t
