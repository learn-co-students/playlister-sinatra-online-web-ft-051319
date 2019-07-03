require 'rack-flash'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  enable :sessions
  use Rack::Flash

  get '/' do
    erb :index
  end

  get '/songs' do
    @songs=Song.all
    erb :'/songs/index'
  end

  get'/artists' do
    @artists=Artist.all
    erb :'/artists/index'
  end

  get '/genres' do
    @genres=Genre.all
    erb :'/genres/index'
  end


  get '/songs/new' do
    @genres=Genre.all
    erb :'/songs/new'
  end

  post '/songs' do
    @song=Song.create(params[:song])
    if !params[:genre][:name].empty?
      @song.genre_ids << Genre.create(name: params[:genre][:name]).id
    else
      if !!Artist.find_by(name: params[:artist][:name])
        @artist=Artist.find_by(name: params[:artist][:name])
        @song.artist=@artist
        @song.save
      else
        @artist=Artist.create(params[:artist])
        @song.artist = @artist
        @song.save
      end
    end
    flash[:message]="Successfully created song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug/edit' do
    @song=Song.find_by_slug(params[:slug])
    @genres=Genre.all
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    @song=Song.find_by_slug(params[:slug])
    #update artist
    if !params[:artist][:name].empty?
      if !!@artist=Artist.find_by(name: params[:artist][:name])
        @artist=Artist.find_by(name: params[:artist][:name])
        @song.artist=@artist
        @song.save
      else
        @artist=Artist.create(params[:artist])
        @song.artist=@artist
        @song.save
      end
    end
    flash[:message]="Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song=Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  get '/artists/:slug' do
    @artist=Artist.find_by_slug(params[:slug])
    erb :'/artists/show'
  end

  get '/genres/:slug' do
    @genre=Genre.find_by_slug(params[:slug])
    erb :'/genres/show'
  end




end
