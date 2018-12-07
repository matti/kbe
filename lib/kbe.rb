require "colorize"
module KBE
  class Error < StandardError; end

  def self.kubectl(*args)
    cmd = []
    cmd << "kubectl"
    cmd << args

    cmd_string = cmd.join " "
    STDERR.puts cmd_string.colorize(:light_black)
    exec cmd_string
  end

  def self.pod_by(selector)
    ["app", "job-name"].each do |selector_prefix|
      magic_selector = if selector.match? "="
        selector
      else
        "#{selector_prefix}=#{selector}"
      end

      pods = `kubectl get pods --no-headers -o custom-columns=":metadata.name" --field-selector=status.phase=Running --selector=#{magic_selector}`.split("\n")
      return pods.first if pods.size == 1

      break if magic_selector == selector
      next if pods.empty?

      STDERR.puts "too many pods"
      exit 1
    end

    STDERR.puts "no pod found"
    exit 1
  end
end

require_relative 'kbe/version'
require_relative 'kbe/cli'

