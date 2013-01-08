require "spec_helper"
require "capistrano/shell"

describe CapistranoRailsConsole::Recipes, "loaded into a configuration" do
  describe "rails:console" do
    before do
      [:rails_env, :user, :current_path].each do |key|
        configuration.set key, "#{key}"
      end
      configuration.set :port, 22
      configuration.role :app, "example.com"
    end

    let :configuration do
      configuration = Capistrano::Configuration.new
      described_class.load_into configuration
      configuration.extend Capistrano::Spec::ConfigurationExtension
    end

    it "defines rails:console" do
      configuration.find_task('rails:console').should_not be_nil
    end

    it "should call 'CapistranoRailsConsole::Rails.console_command'" do
      CapistranoRailsConsole::Rails.should_receive(:console_command).once.and_return("")
      configuration.find_and_execute_task "rails:console"
    end

    it "should run the remote command" do
      CapistranoRailsConsole::Rails.stub(:console_command => "command %s")
      configuration.find_and_execute_task "rails:console"
      configuration.should have_run_locally "ssh -l user example.com -p 22 -t 'cd current_path && command rails_env'"
    end
  end
end
