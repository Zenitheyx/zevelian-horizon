-- ZEVELIAN OS installer v2.1.0
local user = ...
if not user or user == "" then
  print("Usage: install <github-username> [repo] [branch]")
  print("Example: install myname")
  return
end
local repo = select(2, ...) or "zevelian-os"
local branch = select(3, ...) or "main"
local base = ("https://raw.githubusercontent.com/%s/%s/%s/"):format(user, repo, branch)

local manifest = {
  "startup.lua","zevelian.lua",
  "apps/chat.lua","apps/environment.lua","apps/inventory.lua","apps/redstone.lua",
  "apps/settings.lua","apps/system.lua","apps/music.lua","apps/browser.lua","apps/diagnostics.lua",
  "core/boot.lua","core/desktop.lua","core/login.lua",
  "lib/auth.lua","lib/config.lua","lib/hw.lua","lib/meta.lua","lib/theme.lua","lib/ui.lua"
}

local function fetch(path)
  local url = base .. path
  local h, err = http.get(url)
  if not h then return nil, err or "HTTP request failed" end
  local body = h.readAll()
  h.close()
  return body
end

print("ZEVELIAN OS 2.1.0 installer")
print("Repository: " .. user .. "/" .. repo .. " [" .. branch .. "]")
print("Staging " .. #manifest .. " files...")

local staged = {}
for _, path in ipairs(manifest) do
  local body, err = fetch(path)
  if not body then
    print("FAILED: " .. path)
    print(err)
    print("No files were committed.")
    return
  end
  staged[path] = body
  print("  OK  " .. path)
end

local backup = "zevelian_backup"
if fs.exists(backup) then fs.delete(backup) end
fs.makeDir(backup)

local changed = {}
for _, path in ipairs(manifest) do
  if fs.exists(path) then
    fs.makeDir(fs.getDir(backup .. "/" .. path))
    fs.copy(path, backup .. "/" .. path)
  end
end

local ok, problem = pcall(function()
  for path, body in pairs(staged) do
    fs.makeDir(fs.getDir(path))
    local h = fs.open(path, "w")
    if not h then error("Cannot write " .. path) end
    h.write(body)
    h.close()
    table.insert(changed, path)
  end
end)

if not ok then
  print("INSTALL FAILED: " .. tostring(problem))
  for _, path in ipairs(changed) do if fs.exists(path) then fs.delete(path) end end
  for _, path in ipairs(manifest) do
    local old = backup .. "/" .. path
    if fs.exists(old) then
      fs.makeDir(fs.getDir(path))
      fs.copy(old, path)
    end
  end
  fs.delete(backup)
  print("Rollback completed.")
  return
end

fs.delete(backup)
print("")
print("Everything OK. " .. #manifest .. " files installed.")
print("Reboot to start ZEVELIAN OS, or run: zevelian")
print("Default login: admin / zevelian")
