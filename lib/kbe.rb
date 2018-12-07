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

  def self.pod_by(name_or_selector, only_running: true)
    pods = if name_or_selector.match? "="
      get_pods selector: name_or_selector, only_running: only_running
    else
      get_pods name: name_or_selector, only_running: only_running
    end

    if pods.empty?
      ["app", "job-name"].each do |selector_prefix|
        magic_selector = "#{selector_prefix}=#{name_or_selector}"

        pods = get_pods selector: magic_selector, only_running: only_running
        break if pods.any?
      end
    end

    if pods.size == 1
      return pods.first
    elsif pods.size > 1
      STDERR.puts "too many pods found:"
      STDERR.p pods
    else
      STDERR.puts "no pods found."
    end

    exit 1
  end

  def self.get_pods(selector:nil, name:nil, only_running: true)
    parts = []
    parts << "kubectl get pods --no-headers -o custom-columns=':metadata.name'"
    if selector
      parts << "--field-selector=status.phase=Running" if only_running
      parts << "--selector=#{selector}"
    else
      parts << name
    end

    cmd = parts.join " "
    # dev/null supresses the "pod not found" by name
    `#{cmd} 2>/dev/null`.split("\n")
  end
end

require_relative 'kbe/version'
require_relative 'kbe/cli'

