local M = {}
local ui = require("lib.ui")
local theme = require("lib.theme")

local apps = {
  {label="MUSIC", file="apps.music"},
  {label="WEB", file="apps.browser"},
  {label="CHAT", file="apps.chat"},
  {label="ENV", file="apps.environment"},
  {label="INV", file="apps.inventory"},
  {label="REDSTONE", file="apps.redstone"},
  {label="SETTINGS", file="apps.settings"},
  {label="SYSTEM", file="apps.system"},
  {label="DIAGNOSTICS", file="apps.diagnostics"},
}

local function draw(mon, cfg, status)
  mon.setBackgroundColor(theme.bg); mon.setTextColor(theme.fg); mon.clear()
  local w,h = mon.getSize()
  ui.header(mon,"ZEVELIAN OS // HORIZON")
  mon.setCursorPos(2,3)
  mon.setTextColor(theme.dim)
  mon.write(("v2.1.0  |  %dx%d  |  scale %.1f"):format(w,h,mon.getTextScale()))
  local cols = w >= 45 and 3 or 2
  local bw = math.max(10, math.floor((w-2-(cols-1)*2)/cols))
  local startY = 5
  for i,a in ipairs(apps) do
    local c=(i-1)%cols; local r=math.floor((i-1)/cols)
    local x=2+c*(bw+2); local y=startY+r*2
    if y < h-2 then ui.button(mon,x,y,bw,a.label,false) end
  end
  mon.setCursorPos(2,h)
  mon.setTextColor(status and theme.good or theme.dim)
  mon.write(ui.clip(status or "Ready",w-1))
end

function M.run(mon,cfg)
  while true do
    draw(mon,cfg,"Ready")
    local e,side,x,y = os.pullEvent()
    if e == "monitor_resize" then
      -- redraw using the new size
    elseif e == "monitor_touch" then
      local w,h=mon.getSize()
      local cols=w>=45 and 3 or 2
      local bw=math.max(10,math.floor((w-2-(cols-1)*2)/cols))
      if y >= 5 and y < h-1 then
        local row=math.floor((y-5)/2)
        local col=nil
        for c=0,cols-1 do
          local bx=2+c*(bw+2)
          if x>=bx and x<=bx+bw-1 then col=c end
        end
        if col then
          local idx=row*cols+col+1
          local a=apps[idx]
          if a then
            local ok,err=pcall(function() require(a.file).run(mon,cfg) end)
            if not ok then
              mon.clear(); mon.setCursorPos(1,1); mon.setTextColor(theme.bad)
              mon.write("APP ERROR"); mon.setCursorPos(1,3); mon.write(ui.clip(tostring(err),select(1,mon.getSize())))
              sleep(2)
            end
          end
        end
      end
    end
  end
end
return M
