require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models.rb'

require 'open-uri'
require 'json'
require 'net/http'
require 'base64'
require 'rspotify'

require 'dotenv/load'

client_id = ENV['CLIENT_ID']
client_secret = ENV['CLIENT_SECRET']

get '/' do
    # httpレスポンスver
    # params = { grant_type: "client_credentials" }
    # headers = { "Authorization" => 'Basic ' + Base64.urlsafe_encode64(client_id+ ':' + client_secret)}
    # uri = URI.parse("https://accounts.spotify.com/api/token")
    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = uri.scheme === "https"
    # res = http.post(uri.path, params.to_param, headers)
    # res.body
    # json = JSON.parse(res.body)
    # @token = json["access_token"]
    erb :index
end

get '/artist' do
    RSpotify.authenticate(client_id, client_secret)
    artists = RSpotify::Artist.search(params[:artist])
    artist = artists.first
    @artist_name = artist.name
    albums = artist.albums
    @artist_album_name = albums.first.name
    @artist_album_img = albums.first.name
    
    @related_artists = artist.related_artists
    @related_artist = @related_artists.first.name
    
    # artist.name #=> "Arctic Monkeys"
    # related_artists = artist.related_artistsc
    # related_artists.size       #=> 20
    # related_artists.first.name #=> "Miles Kane"
    
    # @artist_name = artists.first.name
    # arctic_bump = artists.first
    erb :result
end
