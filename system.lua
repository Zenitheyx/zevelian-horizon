local M={}
local ui=require("lib.ui")
local meta=require("lib.meta")
function M.run(mon,cfg)
  mon.clear(); ui.header(mon,"SYSTEM")
  local w,h=mon.getSize()
  local info={
    "ZEVELIAN OS "..meta.version.." // "..meta.codename,
    "Computer ID: "..os.getComputerID(),
    "Label: "..tostring(os.getComputerLabel() or "none"),
    "Free space: "..tostring(fs.getFreeSpace("/")),
    "Total space: "..tostring(fs.getCapacity("/")),
    "Monitor: "..w.."x"..h,
    "Text scale: "..tostring(mon.getTextScale()),
  }
  for i,s in ipairs(info) do mon.setCursorPos(2,i+2); mon.write(ui.clip(s,w-3)) end
  mon.setCursorPos(2,h); mon.write("Touch to return"); os.pullEvent("monitor_touch")
end
return M
