set :slim, format: :html

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'development.sqlite3'
)

before do
  @title = 'Facebook Api Sample'
end

get '/' do
  slim :index
end
