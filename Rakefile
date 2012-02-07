$: << File.dirname(__FILE__)

task :default => 'test'

desc "Run all tests"
task :test do
  %w{test:unit test:api test:integration}.each do |task|
    Rake::Task[task].invoke
  end
end

namespace :test do
  desc "Run unit tests"
  task :unit do
    Dir["test/unit/**/*_test.rb"].sort.each { |test| load test }
  end

  desc "Run api tests"
  task :api do
    Dir["test/api/**/*_test.rb"].sort.each { |test| load test }
  end

  desc "Run integration tests"
  task :integration do
    Dir["test/integration/**/*_test.rb"].sort.each { |test| load test }
  end
end
