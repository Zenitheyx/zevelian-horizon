local M={}
local ui=require("lib.ui")
local theme=require("lib.theme")

function M.run(mon,cfg)
  while true do
    mon.clear(); ui.header(mon,"WEB // READER")
    local w,h=mon.getSize()
    mon.setCursorPos(2,3); mon.write("URL: ")
    local url=read()
    if not url or url=="" then return end
    if not http.checkURL(url) then
      mon.setCursorPos(2,5); mon.setTextColor(theme.bad); mon.write("URL is blocked or invalid.")
      sleep(1.5)
    else
      local handle,err=http.get(url)
      if not handle then
        mon.setCursorPos(2,5); mon.setTextColor(theme.bad); mon.write(ui.clip(tostring(err),w-3)); sleep(1.5)
      else
        local body=handle.readAll(); handle.close()
        mon.clear(); ui.header(mon,"WEB // "..url)
        local pos=3
        for line in body:gmatch("[^\r\n]+") do
          if pos>=h-1 then break end
          line=line:gsub("<[^>]->"," "):gsub("%s+"," ")
          pos=ui.wrap(mon,line,2,pos,w-3)
          pos=pos+1
        end
        mon.setCursorPos(2,h); mon.setTextColor(theme.dim); mon.write("Touch to return")
        os.pullEvent("monitor_touch")
      end
    end
  end
end
return M
