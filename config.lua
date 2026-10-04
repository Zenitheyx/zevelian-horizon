local path = "zevelian.cfg"
local defaults = {
  scale = 1,
  accent = colors.cyan,
  autoLogin = false,
  username = "admin",
}

local M = {}

function M.load()
  local data = {}
  if fs.exists(path) then
    local h = fs.open(path, "r")
    if h then
      local raw = h.readAll()
      h.close()
      local ok, decoded = pcall(textutils.unserialize, raw)
      if ok and type(decoded) == "table" then data = decoded end
    end
  end
  for k,v in pairs(defaults) do if data[k] == nil then data[k] = v end end
  return data
end

function M.save(data)
  local h = fs.open(path, "w")
  h.write(textutils.serialize(data))
  h.close()
end

function M.defaults() return defaults end
return M
