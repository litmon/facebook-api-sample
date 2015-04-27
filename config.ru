require 'rubygems'
require 'bundler'
Bundler.require

Dir[File.expand_path('./app', __FILE__) << '/*.rb'].each do |file|
    require file
end

Dotenv.load

use Rack::Session::Cookie, secret: ENV['COOKIE_SESSION_SECRET']
use Rack::Protection

use OmniAuth::Builder do
  provider :facebook,
    ENV['FACEBOOK_API_SAMPLE_APP_ID'],
    ENV['FACEBOOK_API_SAMPLE_APP_SECRET'],
    scope: "public_profile, user_groups, user_managed_groups"
end

run Sinatra::Application
