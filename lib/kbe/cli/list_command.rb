# frozen_string_literal: true

module KBE
  module CLI
    class ListCommand < Clamp::Command
      option ['-h', '--help'], :flag, "help" do
        puts "kbe list"
        exit 0
      end

      def execute
        KBE.kubectl ["get pod"]
      end
    end
  end
end

