local ok, err = pcall(function()
  local boot = require("core.boot")
  boot.start()
end)
if not ok then
  term.clear()
  term.setCursorPos(1,1)
  print("ZEVELIAN OS failed to start.")
  print("")
  print(tostring(err))
  print("")
  print("Press any key to return to the shell.")
  os.pullEvent("key")
end
