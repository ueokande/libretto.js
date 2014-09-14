require 'sinatra'
require 'slim'
require 'coffee-script'
require_relative 'file_list'

set :public_folder, File.dirname(__FILE__)
set :views, File.dirname(__FILE__)

get "/" do
  slim :test
end

get "/scena.js" do
  coffee_from_files viewer_files
end


get "/scena_spec.js" do
  coffee_from_files spec_files
end

get "/index.html" do
  slim :index
end

get "/test.html" do
  slim :test
end

def coffee_from_files(files)
  content = ''
  files.each do |f|
    content += File.read(f)
  end
  coffee content
end
