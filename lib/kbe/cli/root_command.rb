# frozen_string_literal: true
require_relative "version_command"
require_relative "help_command"
require_relative "enter_command"
require_relative "list_command"
require_relative "delete_command"

module KBE
  module CLI
    class RootCommand < Clamp::Command
      banner "kbe 🍻"

      option ['-v', '--version'], :flag, "Show version information" do
        puts KBE::VERSION
        exit(0)
      end
      subcommand ["list"], "List pods", ListCommand
      subcommand ["enter"], "Enter a container", EnterCommand
      subcommand ["delete"], "Delete a pod", DeleteCommand

      subcommand ["version"], "Show version information", VersionCommand
      subcommand ["help"], "Show help", HelpCommand

      def self.run
        super
      rescue StandardError => exc
        warn exc.message
        warn exc.backtrace.join("\n")
      end
    end
  end
end
