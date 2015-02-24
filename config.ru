require 'rack/reverse_proxy'

use Rack::Auth::Basic do |username, password|
  username == ENV['BASIC_AUTH_USERNAME'] && password == ENV['BASIC_AUTH_PASSWORD']
end

use Rack::ReverseProxy do
  reverse_proxy_options :preserve_host => true
  path = ENV['HTTP_PROXY_PATH']
  reverse_proxy '/', path
end

app = proc do |env|
  [ 200, {'Content-Type' => 'text/plain'}, "b" ]
end

run app
