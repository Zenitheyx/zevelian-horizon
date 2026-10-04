local M={}
local ui=require("lib.ui")
function M.run(mon,cfg)
  mon.clear(); ui.header(mon,"INVENTORY")
  local w,h=mon.getSize()
  local p=peripheral.find("inventory")
  if not p then mon.setCursorPos(2,4); mon.write("Inventory Manager offline.")
  else
    local ok,items=pcall(function() return p.list() end)
    if not ok or type(items)~="table" then ok,items=pcall(function() return p.getItems() end) end
    local y=4
    if ok and type(items)=="table" then
      for slot,item in pairs(items) do
        if y>=h-1 then break end
        local label=type(item)=="table" and ((item.name or "?").." x"..tostring(item.count or item.amount or "?")) or tostring(item)
        mon.setCursorPos(2,y); mon.write(ui.clip(slot..": "..label,w-3)); y=y+1
      end
    else mon.setCursorPos(2,4); mon.write("Could not read inventory.") end
  end
  mon.setCursorPos(2,h); mon.write("Touch to return"); os.pullEvent("monitor_touch")
end
return M
