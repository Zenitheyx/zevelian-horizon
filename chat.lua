local M={}
local ui=require("lib.ui")
function M.run(mon,cfg)
  local p=peripheral.find("chatBox")
  mon.clear(); ui.header(mon,"CHAT")
  local w,h=mon.getSize()
  if not p then mon.setCursorPos(2,4); mon.write("Chat Box offline."); sleep(1.5); return end
  mon.setCursorPos(2,4); mon.write("Message: "); local msg=read()
  if msg and msg~="" then
    local ok,err=pcall(function()
      if p.sendMessage then p.sendMessage(msg,"Zevelian") elseif p.broadcast then p.broadcast(msg) else error("No compatible send method") end
    end)
    mon.setCursorPos(2,6); mon.write(ok and "Message sent." or tostring(err))
    sleep(1.2)
  end
end
return M
