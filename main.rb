require 'sinatra'
require 'sinatra/reloader'
require 'json'


helpers do
    def h(text)
        Rack::Utils.escape_html(text)
    end
end

$file_path = "json/data.json"

get '/memos' do
    File.exist?($file_path) ? (@memos = File.open($file_path) {|f| JSON.load(f)}) : (File.open($file_path, 'w')  {|f| f.write("{}")}
    @memos = File.open($file_path) {|f| JSON.load(f)})
    erb:top
end

post '/memos' do
    @memos = File.open($file_path) {|f| JSON.load(f)}
    @memos[SecureRandom.uuid] = {"title" => params['title'], "content" => params['content']}
    File.open($file_path, 'w') {|f| JSON.dump(@memos, f)}
    redirect to "/memos"
end

get '/memos/:id/details' do
    memos = File.open($file_path) {|f| JSON.load(f)} 
    @id = params[:id]
    @memo = memos[@id]
    erb:show
end

get '/new' do
    erb:new
end

get '/memos/:id/edit' do
    memos = File.open($file_path) {|f| JSON.load(f)} 
    @id = params[:id]
    @memo = memos[@id]
    erb:edit
end

patch '/memos/:id' do
    id = params[:id]
    @memos = File.open($file_path) {|f| JSON.load(f)}
    @memos[id] = {"title" => params['title'], "content" => params['content']}
    File.open($file_path, 'w') {|f| JSON.dump(@memos, f)}
    redirect to '/memos'
end

delete '/memos/:id' do
    memos = File.open($file_path) {|f| JSON.load(f)}
    memos.delete(params[:id])
    File.open($file_path, 'w') {|f| JSON.dump(memos, f)} 
    redirect to '/memos'
end