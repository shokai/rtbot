
def app_root
  "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{env['SCRIPT_NAME']}"
end

def request_url
  "#{app_root}#{env['PATH_INFO']}"
end
