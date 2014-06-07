require 'rubygems/tasks'
require 'rake/testtask'
require 'rdoc/task'

task :default => :test

GEMSPEC = Gem::Specification.load(File.join(__dir__, 'uri-tag.gemspec'))

Rake::TestTask.new do |task|
  task.test_files = GEMSPEC.test_files
end

Gem::Tasks.new

Rake::RDocTask.new do |task|
  task.rdoc_files.include GEMSPEC.require_paths.inject([]) {|files, dir| files + Dir.glob("#{dir}/**/*.rb")}, GEMSPEC.extra_rdoc_files
  task.main = 'README.markdown'
end
