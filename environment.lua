local M={}
local ui=require("lib.ui")
function M.run(mon,cfg)
  mon.clear(); ui.header(mon,"ENVIRONMENT")
  local w,h=mon.getSize()
  local p=peripheral.find("environmentDetector")
  if not p then
    mon.setCursorPos(2,4); mon.write("Environment Detector offline.")
  else
    local methods=peripheral.getMethods(peripheral.getName(p))
    local y=4
    mon.setCursorPos(2,y); mon.write("Detector online."); y=y+2
    for _,m in ipairs(methods) do
      if y>=h-1 then break end
      mon.setCursorPos(2,y); mon.write(ui.clip(m,w-3)); y=y+1
    end
  end
  mon.setCursorPos(2,h); mon.write("Touch to return"); os.pullEvent("monitor_touch")
end
return M
