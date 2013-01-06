require "capistrano/configuration"

Capistrano::Configuration.instance(:must_exist).load do
  namespace :rails do
    desc "Open a rails console the first app server"
    task :console, :roles => :app do
      hostname = find_servers_for_task(current_task).first

      console_command = case defined?(Rails::VERSION::MAJOR) && Rails::VERSION::MAJOR
      when 2
        "script/rails console #{rails_env}"
      else
        "rails console #{rails_env}"
      end
      exec "ssh -l #{user} #{hostname} -p #{port} -t 'cd #{current_path} && #{console_command}'"
    end
  end
end
