local M = {}
function M.login()
  term.clear(); term.setCursorPos(1,1)
  print("ZEVELIAN OS")
  print("HORIZON // SECURE LOGIN")
  print("")
  write("Username: ")
  local user = read()
  write("Password: ")
  local pass = read("*")
  if user == "admin" and pass == "zevelian" then return true, user end
  print("")
  print("Invalid credentials.")
  sleep(1.5)
  return false
end
return M
