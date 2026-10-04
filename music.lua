local M = {}
local ui = require("lib.ui")
local theme = require("lib.theme")
local PATH="zevelian_music.db"

local function load()
  if not fs.exists(PATH) then return {} end
  local h=fs.open(PATH,"r"); local raw=h.readAll(); h.close()
  local ok,t=pcall(textutils.unserialize,raw)
  return ok and type(t)=="table" and t or {}
end
local function save(t)
  local h=fs.open(PATH,"w"); h.write(textutils.serialize(t)); h.close()
end
local function msg(mon,s)
  mon.clear(); ui.header(mon,"MUSIC // LIBRARY"); mon.setCursorPos(2,3); mon.write(s)
  sleep(1.2)
end

function M.run(mon,cfg)
  local list=load()
  while true do
    mon.setBackgroundColor(theme.bg); mon.setTextColor(theme.fg); mon.clear()
    ui.header(mon,"MUSIC // LIBRARY")
    local w,h=mon.getSize()
    mon.setCursorPos(2,3); mon.setTextColor(theme.dim)
    local sp=peripheral.find("speaker")
    mon.write(sp and "Speaker detected" or "No speaker connected")
    for i,item in ipairs(list) do
      if 5+i <= h-3 then
        mon.setCursorPos(2,4+i); mon.setTextColor(theme.fg)
        mon.write(ui.clip(i..". "..(item.name or item.url),w-3))
      end
    end
    ui.button(mon,2,h-2,12,"ADD URL",false)
    ui.button(mon,16,h-2,12,"CHECK URL",false)
    ui.button(mon,30,h-2,12,"REMOVE",false)
    ui.button(mon,w-12,h-2,12,"BACK",false)

    local e,side,x,y=os.pullEvent("monitor_touch")
    if y==h-2 then
      if x>=2 and x<14 then
        mon.setCursorPos(2,h-4); mon.write("URL: "); local url=read()
        if url and url~="" then
          mon.setCursorPos(2,h-3); mon.write("Name: "); local name=read()
          table.insert(list,{name=name~="" and name or "Untitled",url=url})
          save(list); msg(mon,"Saved to library.")
        end
      elseif x>=16 and x<28 then
        mon.setCursorPos(2,h-4); mon.write("URL: "); local url=read()
        local ok,reason=http.checkURL(url)
        msg(mon, ok and "URL is allowed." or ("URL blocked: "..tostring(reason)))
      elseif x>=30 and x<42 then
        mon.setCursorPos(2,h-4); mon.write("Number: "); local n=tonumber(read())
        if n and list[n] then table.remove(list,n); save(list); msg(mon,"Removed.") end
      elseif x>=w-12 then return end
    end
  end
end
return M
