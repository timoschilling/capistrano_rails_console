require "capistrano/configuration"
require "capistrano_rails_console/rails"

Capistrano::Configuration.instance(:must_exist).load do
  namespace :rails do
    desc "Open a rails console the first app server"
    task :console, :roles => :app do
      hostname = find_servers_for_task(current_task).first

      console_command = CapistranoRailsConsole::Rails.console_command % rails_env
      exec "ssh -l #{user} #{hostname} -p #{port} -t 'cd #{current_path} && #{console_command}'"
    end
  end
end
