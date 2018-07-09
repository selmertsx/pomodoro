local opts = {
  redirect_uri_path = ""
  discovery = ""
  client_id = ""
  client_secret = ""
}

local res, err = require("resty.openidc").authenticate(opts)

if err then
  ngx.status = 500
  ngx.say(err)
  ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end

ngx.req.set_header("X-USER", res.id_token.sub)
