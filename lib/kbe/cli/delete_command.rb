# frozen_string_literal: true
require "json"

module KBE
  module CLI
    class DeleteCommand < Clamp::Command
      option ['-h', '--help'], :flag, "help" do
        puts "kbe delete selector"
        exit 0
      end

      parameter "SELECTOR_OR_POD", "selector or pod name"

      def execute
        pod = KBE.pod_by(selector_or_pod, only_running: false)
        KBE.kubectl "delete pod #{pod}"
      end
    end
  end
end

