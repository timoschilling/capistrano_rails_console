require "bundler/gem_tasks"

require "rspec"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new("test:spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

namespace :test do
  desc "Run integration test"
  task :integration do
    puts
    puts "Start integration test"
    unless `cap -T` =~ /rails:console/
      puts "Integration test fails!"
      exit!
    else
      puts "Integration test successfully!"
    end
  end
end

desc "Run integration tests and specs"
task :test => ["test:spec", "test:integration"]
task :default => :test
