if not pcall(require, "telescope") then
  return
end
local log = require("lvm.telescope.log")
TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, options, buffer)
  if not key then
    log.error("map_tele: key is missig")
    return
  end

  if not f then
    log.error("map_tele: f is missig")
    return
  end
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  local override_map_options = {}
  if options and type(options.keymap) == "table" then
    override_map_options = options.keymap
    options.keymap = nil
  end

  TelescopeMapArgs[map_key] = options or {}

  local mode = "n"
  local rhs = string.format("<cmd>lua R('lvm.telescope.api')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
  }

  if override_map_options.desc then
    map_options.desc = override_map_options.desc
  end

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true })

return map_tele
