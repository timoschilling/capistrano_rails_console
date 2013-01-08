require "spec_helper"

describe CapistranoRailsConsole::Rails do
  describe ".version" do
    it "should require 'rails/version'" do
      described_class.should_receive(:require).once.with("rails/version")
      described_class.version rescue nil
    end

    it "should raise an exception if can not require 'rails/version'" do
      expect { described_class.version }.to raise_error
    end

    it "should return the value of Rails::VERSION::MAJOR" do
      stub_const "Rails::VERSION::MAJOR", 3
      described_class.stub :require
      described_class.version.should be 3
    end

    it "should raise an exception if Rails::VERSION::MAJOR is not defined" do
      described_class.stub :require
      expect { described_class.version }.to raise_error
    end
  end

  describe ".console_command" do
    it "should return the Rails 2 command" do
      described_class.stub :version => 2
      described_class.console_command.should eq "./script/console %s"
    end

    it "should return the Rails 3 command" do
      described_class.stub :version => 3
      described_class.console_command.should eq "rails console %s"
    end
  end
end
