# frozen_string_literal: true

module KBE
  module CLI
    class EnterCommand < Clamp::Command
      option ['-h', '--help'], :flag, "help" do
        puts "kbe enter myapp"
        puts "kbe enter myapp -c first"
        puts "kbe enter myapp -c first -- uptime -h"
        puts "kbe enter app=myapp -c first -- uptime -h"
        exit 0
      end

      option ['-c', '--container'], 'CONTAINER', 'container', default: :first

      parameter "SELECTOR_OR_POD", "selector or pod name"
      parameter "[CMD] ...", "cmd"

      def execute
        cmd_list = ["sh"] unless cmd_list
        pod = KBE.pod_by selector_or_pod

        args = []
        args << "exec -it #{pod}"
        unless container == :first
          args << "-c #{container}"
        end
        args << cmd_list.join(" ")

        KBE.kubectl args
      end
    end
  end
end

