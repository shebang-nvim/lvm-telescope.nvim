local log = require("lvm.telescope.log")
if not pcall(require, "telescope") then
  return
end

local load_extensions = function(config)
  for ext_name, ext_conf in pairs(config.telescope.extensions) do
    log.debug(string.format("LvmTelescope: try loading extension: %s", ext_name))

    local ok, _ = pcall(require("telescope").load_extension, ext_name)
    if not ok then
      log.debug(string.format("LvmTelescope: loading extension: %s failed! Not installed but config present?", ext_name))
    end
  end
end

return {
  setup = function(config)
    log.debug("LvmTelescope: calling telescope.setup()")
    require("telescope").setup(config.telescope)

    load_extensions(config)
  end,
}
