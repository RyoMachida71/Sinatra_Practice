require 'sinatra'
require 'sinatra/reloader'
require 'json'


get '/memos' do
    @memos = File.open("json/test.json") {|f| JSON.load(f)}
    erb:top
end

post '/memos' do
    @memos = File.open("json/test.json") {|f| JSON.load(f)}
    @memos[SecureRandom.uuid] = {"title" => params['title'], "content" => params['content']}
    File.open("json/test.json", 'w') {|f| JSON.dump(@memos, f)}
    erb:top
end

get '/memos/:id/details' do
    memos = File.open("json/test.json") {|f| JSON.load(f)} 
    @id = params[:id]
    @memo = memos[@id]
    erb:show
end

get '/new' do
    erb:new
end

get '/memos/:id/edit' do
    memos = File.open("json/test.json") {|f| JSON.load(f)} 
    @id = params[:id]
    @memo = memos[@id]
    erb:edit
end

patch '/memos/:id' do
    id = params[:id]
    @memos = File.open("json/test.json") {|f| JSON.load(f)}
    @memos[id] = {"title" => params['title'], "content" => params['content']}
    File.open("json/test.json", 'w') {|f| JSON.dump(@memos, f)}
    redirect to '/memos'
end

delete '/memos/:id' do
    memos = File.open("json/test.json") {|f| JSON.load(f)}
    memos.delete(params[:id])
    File.open("json/test.json", 'w') {|f| JSON.dump(memos, f)} 
    redirect to '/memos'
end