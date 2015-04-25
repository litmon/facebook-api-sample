require 'sinatra'
require 'sinatra/reloader' if development?
require 'slim'
require 'active_record'

set :slim, format: :html

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'development.sqlite3'
)

@title = 'Facebook Api Sample'

get '/' do
  'Hello World!'
end
