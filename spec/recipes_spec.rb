require "spec_helper"
require "capistrano/shell"

describe CapistranoRailsConsole::Recipes, "loaded into a configuration" do
  describe "rails:console" do
    before do
      configuration.role :app, "example.com"
      configuration.set :rails_env, "rails_env"
      configuration.set :current_path, "current_path"
      CapistranoRailsConsole::Rails.stub(:console_command => "command %s")
    end

    let :configuration do
      configuration = Capistrano::Configuration.new
      described_class.load_into configuration
      configuration.extend Capistrano::Spec::ConfigurationExtension
    end

    context "normal operations" do
      before do
        configuration.set :user, "user"
        configuration.set :port, 22
      end

      it "defines rails:console" do
        configuration.find_task('rails:console').should_not be_nil
      end

      it "should call 'CapistranoRailsConsole::Rails.console_command'" do
        CapistranoRailsConsole::Rails.should_receive(:console_command).once.and_return("")
        configuration.find_and_execute_task "rails:console"
      end

      it "should run the remote command" do
        configuration.find_and_execute_task "rails:console"
        configuration.should have_run_locally "ssh -l user example.com -p 22 -t 'cd current_path && command rails_env'"
      end
    end

    context "when port is not defined" do
      before do
        configuration.set :user, "user"
      end

      it "should not blow up" do
        lambda { configuration.find_and_execute_task('rails:console') }.should_not raise_error
      end

      it "should not include the port in the command" do
        configuration.find_and_execute_task "rails:console"
        configuration.should have_run_locally "ssh -l user example.com -t 'cd current_path && command rails_env'"
      end
    end

    context "when the user is not defined" do
      before do
        configuration.set :port, 22
      end

      it "should not blow up" do
        lambda { configuration.find_and_execute_task('rails:console') }.should_not raise_error
      end

      it "shoudl not include the login in the path" do
        configuration.find_and_execute_task "rails:console"
        configuration.should have_run_locally "ssh example.com -p 22 -t 'cd current_path && command rails_env'"
      end
    end
  end
end
