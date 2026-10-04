local M={}
local ui=require("lib.ui")
local theme=require("lib.theme")
function M.run(mon,cfg)
  mon.clear(); ui.header(mon,"SYSTEM // DIAGNOSTICS")
  local w,h=mon.getSize()
  local names=peripheral.getNames()
  mon.setCursorPos(2,3); mon.write(("Monitor: %dx%d  scale %.1f"):format(w,h,mon.getTextScale()))
  mon.setCursorPos(2,4); mon.write("Peripherals: "..#names)
  local y=6
  for _,n in ipairs(names) do
    if y>=h-1 then break end
    mon.setCursorPos(2,y)
    local typ=peripheral.getType(n)
    if type(typ)=="table" then typ=table.concat(typ,",") end
    mon.write(ui.clip(n.." = "..tostring(typ),w-3)); y=y+1
  end
  mon.setCursorPos(2,h); mon.setTextColor(theme.dim); mon.write("Touch to return")
  os.pullEvent("monitor_touch")
end
return M
