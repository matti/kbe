# frozen_string_literal: true

module KBE
  module CLI
    class HelpCommand < Clamp::Command
      def execute
        exec "kbe -h"
      end
    end
  end
end
