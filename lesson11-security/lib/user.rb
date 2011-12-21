
def authenticate(params)
  if params["login"] == "pippo" && params["password"] == "pluto"
    return 1234
  else
    return false
  end
end
