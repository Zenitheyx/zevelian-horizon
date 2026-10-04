local M={}
local ui=require("lib.ui")
local theme=require("lib.theme")
function M.run(mon,cfg)
  while true do
    mon.clear(); ui.header(mon,"SETTINGS")
    local w,h=mon.getSize()
    mon.setCursorPos(2,3); mon.write("Current scale: "..tostring(mon.getTextScale()))
    local scales={0.5,1,1.5,2,2.5,3,4,5}
    for i,s in ipairs(scales) do
      local x=2+((i-1)%4)*10; local y=5+math.floor((i-1)/4)*2
      ui.button(mon,x,y,9,tostring(s),false)
    end
    ui.button(mon,2,h-2,14,"AUTO FIT",false)
    ui.button(mon,w-14,h-2,14,"BACK",false)
    local e,side,x,y=os.pullEvent("monitor_touch")
    if y>=5 and y<=8 then
      local row=math.floor((y-5)/2); local col=math.floor((x-2)/10)
      local idx=row*4+col+1; local s=scales[idx]
      if s then mon.setTextScale(s); cfg.scale=s; require("lib.config").save(cfg) end
    elseif y==h-2 and x<16 then
      local target=1
      local mw,mh=mon.getSize()
      if mw>=60 then target=1 elseif mw>=40 then target=1.5 else target=2 end
      mon.setTextScale(target); cfg.scale=target; require("lib.config").save(cfg)
    elseif y==h-2 and x>=w-14 then return end
  end
end
return M
