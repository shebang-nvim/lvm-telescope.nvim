local utils = {}

local Keys = require("lazy.core.handler.keys")
utils.format_for_log = function(v)
  return vim.inspect(v):gsub("\n", "")
end


utils.build_lazy_keys = function(t)
  local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>
  for _, value in ipairs(t) do
    local keys = Keys.parse(value)
    if keys[2] == vim.NIL or keys[2] == false then
      keymaps[keys.id] = nil
    else
      keymaps[keys.id] = keys
    end
  end
  return keymaps
end

utils.only_1st_elem = function(t)
  local r = {}
  for index, value in ipairs(t) do
    if value[1] then
      r[index] = value[1]
    end
  end
  return r
end

return utils
