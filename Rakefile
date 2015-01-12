require 'bundler/gem_tasks'
require 'rake/clean'
require 'yard'

CLEAN.include(Dir['**/*'] - `git ls-files`.split("\n"))
Rake::Task['clobber'].clear

YARD::Rake::YardocTask.new do |yard|
  yard.options = [
    '--title',  'Gnosis Documentation',
    '--readme', 'README.md',
    '--files',  'LICENSE',
    '--markup', 'markdown'
  ]
end

namespace :yard do
  desc 'Remove YARD Documentation'
  task :clean do
    rm_r('doc/') if File.directory?('doc/')
  end
  
  desc 'Start YARD Documentation server on localhost:8808'
  task :serve do
    sh 'yard server -r'
  end
end

namespace :spec do
  desc 'Run detailed RSpec tests'
  task :nested do
    sh 'rspec spec --color --format documentation'
  end
  
  desc 'Run RSpec tests (`rake` default task)'
  task :run do
    sh 'rspec spec --color'
  end
end

task :clean   => 'yard:clean'
task :spec    => 'spec:nested'
task :default => 'spec:run'