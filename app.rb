require 'dotenv'
Dotenv.load

require 'sinatra'
require 'cgi'

require 'http'
require 'json'

enable :sessions

before do
  @client_id = ENV['CLIENT_ID']
  @client_secret = ENV['CLIENT_SECRET']

  session[:oauth] ||= {}
end

get '/' do
  if session[:oauth][:access_token].nil?
    erb :login
  else
    response = HTTP.get(
      'https://graph.facebook.com'\
      "/me?access_token=#{session[:oauth][:access_token]}"
    )
    data = JSON.parse(response.body)

    @name = data['name']
    @access_token = session[:oauth][:access_token]

    erb :logged_in
  end
end

get '/login' do
  redirect(
    'https://graph.facebook.com/oauth/authorize'\
    "?client_id=#{@client_id}"\
    '&redirect_uri=http://localhost:4567/callback'
  )
end

get '/callback' do
  session[:oauth][:code] = params[:code]

  response = HTTP.get(
    'https://graph.facebook.com/oauth/access_token'\
    "?client_id=#{@client_id}"\
    '&redirect_uri=http://localhost:4567/callback'\
    "&client_secret=#{@client_secret}"\
    "&code=#{session[:oauth][:code]}"
  )

  session[:oauth][:access_token] = CGI.parse(response.to_s)['access_token'][0]
  redirect '/'
end

get '/logout' do
  session[:oauth] = {}
  redirect '/'
end
