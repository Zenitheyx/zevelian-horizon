local M={}
local ui=require("lib.ui")
function M.run(mon,cfg)
  local p=peripheral.find("redstoneIntegrator")
  if not p then mon.clear(); ui.header(mon,"REDSTONE"); mon.setCursorPos(2,4); mon.write("Redstone Integrator offline."); sleep(1.5); return end
  while true do
    mon.clear(); ui.header(mon,"REDSTONE")
    local w,h=mon.getSize()
    ui.button(mon,2,4,16,"ALL ON",false)
    ui.button(mon,20,4,16,"ALL OFF",false)
    ui.button(mon,w-14,h-2,14,"BACK",false)
    mon.setCursorPos(2,7); mon.write("Safety: actions affect the connected integrator.")
    local e,side,x,y=os.pullEvent("monitor_touch")
    if y==4 and x<18 then
      for _,s in ipairs({"left","right","front","back","top","bottom"}) do p.setOutput(s,true) end
    elseif y==4 and x>=20 and x<36 then
      for _,s in ipairs({"left","right","front","back","top","bottom"}) do p.setOutput(s,false) end
    elseif y==h-2 and x>=w-14 then return end
  end
end
return M
