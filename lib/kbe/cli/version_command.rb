# frozen_string_literal: true

module KBE
  module CLI
    class VersionCommand < Clamp::Command
      def execute
        puts KBE::VERSION
      end
    end
  end
end
