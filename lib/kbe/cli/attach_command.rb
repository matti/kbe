# frozen_string_literal: true

module KBE
  module CLI
    class AttachCommand < Clamp::Command
      option ['-h', '--help'], :flag, "help" do
        puts "kbe attach myapp"
        exit 0
      end

      option ['-c', '--container'], 'CONTAINER', 'container', default: :first

      parameter "SELECTOR_OR_POD", "selector or pod name"

      def execute
        pod = KBE.pod_by selector_or_pod

        args = []
        args << "attach -it #{pod}"
        unless container == :first
          args << "-c #{container}"
        end

        KBE.kubectl args
      end
    end
  end
end

