require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

configure do
  set :slim, format: :html
  set :database, {
    adapter: 'sqlite3', database: 'development.sqlite3'
  }
end

def oauth_consumer
  Koala::Facebook::OAuth.new(
    ENV['FACEBOOK_API_SAMPLE_APP_ID'], 
    ENV['FACEBOOK_API_SAMPLE_APP_SECRET']
  )
end

def koala
  Koala::Facebook::API.new(session[:facebook_access_token])
end

def base_url
  "#{request.scheme}://#{request.host}:#{request.port.to_s}"
end

before do
  @title = 'Facebook Api Sample'

  @graph = if session[:facebook_access_token]
             koala
           else
             nil
           end
end

get '/' do
  # puts @graph
  slim :index
end

get '/auth/:name/callback' do
  url = "#{base_url}/auth/#{params[:name]}/callback"
  session[:facebook_access_token] =
    oauth_consumer.get_access_token(params[:code], redirect_uri: url)

  redirect '/'
end
