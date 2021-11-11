require 'sinatra'
require 'sinatra/reloader'

get '/top' do
    erb:top
end

post '/top' do
    @title = params['title']
    @content = params['content']
    erb:top
end

get '/top/:title' do
    @title = params['title']
    @content = params['content']
    erb:show
end

get '/new' do
    erb:new
end

post '/new' do 
    @title = params['title']
    erb:new
end