local http = require "resty.http"
local httpc = http.new()
local res, err = httpc:request_uri("http://selmertsx.hatenablog.com/", {
  method = "GET",
  headers = {
    ["Content-Type"] = "application/x-www-form-urlencoded",
  }
})

if not res then
  ngx.say("failed to request: ", err)
  return
end

ngx.say(res.body)
