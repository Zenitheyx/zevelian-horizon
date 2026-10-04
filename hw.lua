local M = {}

function M.findMonitor()
  if peripheral.isPresent("top") and peripheral.hasType("top","monitor") then
    return peripheral.wrap("top"), "top"
  end
  local m, name = peripheral.find("monitor")
  return m, name
end

function M.names()
  return peripheral.getNames()
end

function M.types(name)
  local t = peripheral.getType(name)
  if type(t) == "table" then return table.concat(t, ",") end
  return tostring(t or "?")
end

function M.findSpeaker()
  return peripheral.find("speaker")
end

function M.inventory()
  return peripheral.find("inventory")
end

function M.chatbox()
  local p = peripheral.find("chatBox")
  if p then return p end
  for _,n in ipairs(peripheral.getNames()) do
    if peripheral.hasType(n,"chatBox") then return peripheral.wrap(n) end
  end
end

return M
