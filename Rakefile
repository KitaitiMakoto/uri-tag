require 'rubygems/tasks'
require 'rake/testtask'

Rake::TestTask.new do |task|
  task.test_files = Gem::Specification.load(File.join(__dir__, 'uri-tag.gemspec')).test_files
end

Gem::Tasks.new
