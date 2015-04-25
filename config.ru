require 'rubygems'
require 'bundler'
Bundler.require

Dir[File.expand_path('./app', __FILE__) << '/*.rb'].each do |file|
    require file
end

run Sinatra::Application
