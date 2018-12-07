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

      parameter "[POD]", "pod"

      def execute
        if pod
          json = JSON.parse(`kubectl get pod #{pod} -o json`)
          for container in json["spec"]["containers"]
            puts container["name"]
          end
        else
          KBE.kubectl ["get pod"]
        end
      end
    end
  end
end

