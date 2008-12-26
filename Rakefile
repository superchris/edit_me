require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'git'

load 'tasks/edit_me.rake'

desc 'Default: run unit tests.'
task :default => :test

desc 'Setup test repo'
task :setup_test_repo do |t|
  puts "setting up the repo"
end

desc 'Test the content_editor plugin.'
Rake::TestTask.new(:test => :setup_test_repo) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the content_editor plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ContentEditor'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
