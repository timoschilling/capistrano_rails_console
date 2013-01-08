module CapistranoRailsConsole
  module Rails
    def self.version
      begin
        require "rails/version"
        ::Rails::VERSION::MAJOR
      rescue
        raise "can not detect rails version"
      end
    end

    def self.console_command
      if version == 2
        "./script/console %s"
      else
        "rails console %s"
      end
    end
  end
end
