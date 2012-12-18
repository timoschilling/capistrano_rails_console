require "capistrano/configuration"

Capistrano::Configuration.instance(:must_exist).load do
  namespace :rails do
    desc "Open a rails console the first app server"
    task :console, :roles => :app do
      hostname = find_servers_for_task(current_task).first
      exec "ssh -l #{user} #{hostname} -p #{port} -t 'cd #{current_path} && rails c #{rails_env}'"
    end
  end
end
