local lvm = lvm
local TelescopeModule = {}
local spec = {
	module_name = "telescope",
	plugin_name = "shebang/lvm-telescope.nvim",
	description = "Provides a telescope module",
	kind = "feature",
}

local H = {}
TelescopeModule.map_tele = require("lvm.modules.telescope.mappings")

TelescopeModule.setup = function(config)
	-- local lazy_config = require("lazy.core.config")

	-- lazy_config.spec.modules:append("lvm.modules.telescope.plugins")

	-- Setup config
	config = H.setup_config(config)

	require("lvm.modules.telescope.setup").setup(config.telescope)

	-- Apply config
	H.apply_config(config)

	lvm.register_module(TelescopeModule, spec)
	return TelescopeModule
end
--- Module config
---
TelescopeModule.config = {}
--minidoc_afterlines_end

-- Helper data ================================================================
-- Module default config
H.default_config = require("lvm.modules.telescope.config").defaults

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
H.setup_config = function(config)
	-- General idea: if some table elements are not present in user-supplied
	-- `config`, take them from default config
	vim.validate({ config = { config, "table", true } })
	config = vim.tbl_deep_extend("force", H.default_config, config or {})

	return config
end

H.apply_config = function(config)
	TelescopeModule.config = config

	local Keys = require("lazy.core.handler.keys")
	local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

	for _, value in ipairs(config.module.keymaps) do
		local keys = Keys.parse(value)
		if keys[2] == vim.NIL or keys[2] == false then
			keymaps[keys.id] = nil
		else
			keymaps[keys.id] = keys
		end
	end
	for _, keys in pairs(keymaps) do
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
			TelescopeModule.map_tele(keys[1], keys[2], picker_opts)
		end
	end
end

return TelescopeModule
