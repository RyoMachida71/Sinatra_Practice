require 'sinatra'
require 'sinatra/reloader'
require 'json'


get '/top' do
    erb:top
end

post '/top' do
    @title = params['title']
    @content = params['content']
    File.open("json/test.json", 'w') do |file|
        json = {"id" => 1, "title" => params['title'], "content" => params['content']}
        str = JSON.dump(json, file)
    end
    erb:top
end

get '/top/:title' do
    File.open("json/test.json", 'r') do |file|
        @hash = JSON.load(file)
    end
    erb:show
end

get '/new' do
    erb:new
end

post '/new' do 
    @title = params['title']
    erb:new
end
