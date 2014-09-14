require 'sinatra'
require 'slim'
require 'coffee-script'

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

def editor_files
  Dir.glob(File.expand_path('../src/plugins/**/*.coffee',  __FILE__)) +
  Dir.glob(File.expand_path('../src/core/**/*.coffee',  __FILE__))
end

def viewer_files
  Dir.glob(File.expand_path('../src/main.coffee',  __FILE__)) +
  Dir.glob(File.expand_path('../src/core/**/*.coffee',  __FILE__)) +
  Dir.glob(File.expand_path('../src/plugins/**/*.coffee',  __FILE__))
end

def spec_files
  Dir.glob(File.expand_path('../spec/**/*.coffee',  __FILE__))
end

