# frozen_string_literal: true
require "json"

module KBE
  module CLI
    class ListCommand < Clamp::Command
      option ['-h', '--help'], :flag, "help" do
        puts "kbe list"
        puts "kbe list pod"
        exit 0
      end

      parameter "[POD]", "list containers from pod", attribute_name: :selector

      def execute
        if selector
          pod = KBE.pod_by(selector, only_running: false)
          json = JSON.parse(`kubectl get pod #{pod} -o json`)
          for container in json["spec"]["containers"]
            puts container["name"]
          end
        else
          KBE.kubectl ["get pod"]
        end
      rescue JSON::ParserError
      end
    end
  end
end

