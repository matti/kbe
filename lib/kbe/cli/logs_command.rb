# frozen_string_literal: true

module KBE
  module CLI
    class LogsCommand < Clamp::Command
      option ['-h', '--help'], :flag, "help" do
        puts "kbe delete selector"
        exit 0
      end

      parameter "SELECTOR_OR_POD", "selector or pod name"
      parameter "[CONTAINER]", "container"

      def execute
        pod = KBE.pod_by(selector_or_pod, only_running: false)
        parts = []
        parts << "logs --tail=10 -f #{pod}"
        parts << "-c #{container}" if container # let error because it gives the list

        KBE.kubectl parts.join(" ")
      end
    end
  end
end

