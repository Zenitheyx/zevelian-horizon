local M = {}
local theme = require("lib.theme")

function M.clip(s, n)
  s = tostring(s or "")
  if #s <= n then return s end
  if n <= 3 then return s:sub(1,n) end
  return s:sub(1,n-3) .. "..."
end

function M.center(t, y, text, color)
  local w = select(1, t.getSize())
  t.setCursorPos(math.max(1, math.floor((w-#text)/2)+1), y)
  if color then t.setTextColor(color) end
  t.write(text)
end

function M.header(t, title)
  local w = select(1, t.getSize())
  t.setBackgroundColor(theme.panel); t.setTextColor(theme.fg)
  t.setCursorPos(1,1); t.write(string.rep(" ",w))
  M.center(t,1,M.clip(title,w),theme.fg)
  t.setBackgroundColor(theme.bg)
end

function M.button(t,x,y,w,label,active)
  t.setCursorPos(x,y)
  t.setBackgroundColor(active and theme.accent or theme.panel)
  t.setTextColor(active and colors.black or theme.fg)
  t.write("[" .. M.clip(label, math.max(1,w-2)) .. "]")
  t.setBackgroundColor(theme.bg)
end

function M.wrap(t, text, x, y, width)
  local line = ""
  local row = y
  for word in tostring(text):gmatch("%S+") do
    if #line + #word + 1 > width then
      t.setCursorPos(x,row); t.write(line); row=row+1; line=""
    end
    line = line=="" and word or line.." "..word
  end
  if line ~= "" then t.setCursorPos(x,row); t.write(line); row=row+1 end
  return row
end

return M
