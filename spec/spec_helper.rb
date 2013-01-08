require "rspec"
require "capistrano"
require "capistrano-spec"
require "capistrano_rails_console/recipes"

RSpec.configure do |config|
  config.include Capistrano::Spec::Matchers
  config.include Capistrano::Spec::Helpers
end
