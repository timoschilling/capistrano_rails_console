require "rspec"
require "capistrano"
require "capistrano-spec"
require "capistrano_rails_console/recipes"

RSpec.configure do |config|
  config.include Capistrano::Spec::Matchers
  config.include Capistrano::Spec::Helpers
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end
