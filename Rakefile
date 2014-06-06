require 'rubygems/tasks'
require 'rake/testtask'
require 'rdoc/task'

task :default => :test

Rake::TestTask.new do |task|
  task.test_files = Gem::Specification.load(File.join(__dir__, 'uri-tag.gemspec')).test_files
end

Gem::Tasks.new
Rake::RDocTask.new do |task|
  spec = Gem::Specification.load(File.join(__dir__, 'uri-tag.gemspec'))
  task.rdoc_files = spec.require_paths.inject([]) {|files, dir| files + Dir.glob("#{dir}/**/*.rb")} + spec.extra_rdoc_files
  task.main = 'README.markdown'
end
