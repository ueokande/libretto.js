require 'coffee_script'
require 'jasmine'
require_relative 'file_list'
load 'jasmine/tasks/jasmine.rake'

def file_coffee_task(target, sources)
  file target => sources do |t|
    open t.name, 'w' do |f|
      content = ''
      sources.each do |s|
        content += File.read(s)
      end
      f.puts CoffeeScript.compile(content)
    end
  end
end

task :default => [:build]

desc "Build a javascripts"
task :build => ['js', 'js/scena.js', 'js/scena_editor.js', 'js/scena_spec.js']

directory 'js'
file_coffee_task 'js/scena.js', viewer_files
file_coffee_task 'js/scena_editor.js', editor_files
file_coffee_task 'js/scena_spec.js', spec_files

desc 'Run specs via server:ci'
task :spec_server => [:build] do
  ENV['JASMINE_CONFIG_PATH'] = 'jasmine.yml'
  Rake::Task[:jasmine].invoke
end
