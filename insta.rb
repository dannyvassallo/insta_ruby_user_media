require "sinatra"
require "instagram"
require 'dotenv'
Dotenv.load

enable :sessions

CALLBACK_URL = "http://localhost:4567/oauth/callback"

Instagram.configure do |config|
  config.client_id = ENV['INSTA_CLIENT_ID']
  config.client_secret = ENV['INSTA_CLIENT_SECRET']
end

get "/" do
  '<a href="/oauth/connect">Connect with Instagram</a>'
end

get "/oauth/connect" do
  redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL, :scope => 'basic public_content follower_list comments relationships likes')
end

get "/oauth/callback" do
  response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
  session[:access_token] = response.access_token
  redirect "/user_recent_media"
end

get "/user_recent_media" do
  client = Instagram.client(:access_token => session[:access_token])
  user = client.user
  html = "<h1>#{user.username}'s recent media</h1>"
  html << "<a href='/logout'>Log Out</a>"
  for media_item in client.user_recent_media
    if media_item.type === "video"
      html << "<div style='float:left;'><a href='#{media_item.link}' target='_blank'><img src='#{media_item.images.thumbnail.url}'></a><br/> <a href='/media_like/#{media_item.id}'>Like</a>  <a href='/media_unlike/#{media_item.id}'>Un-Like</a>  <br/>LikesCount=#{media_item.likes[:count]}</div><p>#{media_item}</p>"
    end
  end
  html
end

get '/logout' do
  session.clear
  if session.clear
    redirect "/"
  end
end
