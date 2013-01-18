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
            local_ssh_command = ["ssh"]
            local_ssh_command << "-l #{user}" if fetch(:user, nil)
            local_ssh_command << hostname
            local_ssh_command << "-p #{port}" if fetch(:port, nil)
            local_ssh_command << "-t 'cd #{current_path} && #{console_command}'"

            run_locally(local_ssh_command.join(" "))
          end
        end
      end
    end
  end
end

if Capistrano::Configuration.instance
  CapistranoRailsConsole::Recipes.load_into(Capistrano::Configuration.instance)
end
