local M = {}
function M.start()
  local cfg = require("lib.config").load()
  local mon = require("lib.hw").findMonitor()
  local auth = require("lib.auth")
  if not mon then error("No monitor peripheral found.") end

  mon.setTextScale(cfg.scale or 1)
  if not cfg.autoLogin then
    local ok, user = auth.login()
    if not ok then return end
    cfg.username = user
    require("lib.config").save(cfg)
  end

  local desktop = require("core.desktop")
  desktop.run(mon, cfg)
end
return M
