require 'sinatra'
require 'slim'
require 'coffee-script'
require 'jasmine-core'
require_relative 'file_list'

set :public_folder, File.dirname(__FILE__)
set :views, File.dirname(__FILE__)

get "/" do
  slim :index
end

get "/scena.js" do
  coffee_from_files viewer_files
end

get "/scena_spec.js" do
  coffee_from_files spec_files
end

get "/scena_editor.js" do
  coffee_from_files editor_files
end

get "/index.html" do
  slim :index
end

get "/test.html" do
  slim :test
end

get '/jasmine/*.js' do |path|
  content_type 'application/javascript'
  File.read File.join(Jasmine::Core.path, path + '.js')
end

get '/jasmine/*.css' do |path|
  content_type 'text/css'
  File.read File.join(Jasmine::Core.path, path + '.css')
end

def coffee_from_files(files)
  content = ''
  files.each do |f|
    content += File.read(f)
  end
  coffee content
end
