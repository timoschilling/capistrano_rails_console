require "capistrano"
require "capistrano_rails_console/rails"

module CapistranoRailsConsole
  module Recipes
    def self.load_into(configuration)
      configuration.load do
        namespace :rails do
          desc "Open a rails console the first app server"
          task :console, :roles => :app do
            hostname = find_servers_for_task(current_task).first

            console_command = CapistranoRailsConsole::Rails.console_command % rails_env
            run_locally "ssh -l #{user} #{hostname} -p #{port} -t 'cd #{current_path} && #{console_command}'"
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  CapistranoRailsConsole::Recipes.load_into(Capistrano::Configuration.instance)
end
