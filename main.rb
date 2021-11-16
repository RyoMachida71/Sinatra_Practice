require 'sinatra'
require 'sinatra/reloader'
require 'json'


get '/top' do
    @memos = Dir.glob('json/*').map { |file| JSON.parse(File.open(file).read)}
    @memos = @memos.sort_by { |file| file["time"]}
    erb:top
end

post '/top' do
    memo = { "id" => SecureRandom.random_number(n = 1000), "title" => params['title'], "content" => params['content'], "time" => Time.now}
    File.open("json/memos_#{memo["id"]}.json", 'w') { |file| JSON.dump(memo, file)}
    @memos = memo
    erb:top
end

get '/top/:id' do
    memo = File.open("json/memos_#{id}.json") { |file| JSON.parse(file.read)}
    @title = memo["title"]
    @content = memo["content"]
    @id = memo["id"]
    erb:show
end

get '/new' do
    erb:new
end

post '/new' do 
    @title = params['title']
    erb:new
end
