require 'minitest/autorun'
require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/*/test_*.rb']
  t.verbose = true
end

task :console do
  exec 'irb -r rmetrics -I ./lib'
end

require 'coveralls/rake/task'
Coveralls::RakeTask.new
task test_with_coveralls: [:spec, :features, 'coveralls:push']

desc 'Run tests'
task default: :test
