
class Logi; end
module Logi::Runner
  module_function
  def options
  end

  def run argv=ARGV
    require 'logi'
    Logi.new('example').make
  end

  def post argv=ARGV
    require 'logi/command/post'
  end

  def list argv=ARGV
    require 'logi/command/list'
  end

  def parse argv
  end

  def help
    maxn = options.transpose.first.map(&:size).max
    maxd = options.transpose.last .map(&:size).max
    "Usage: logi [OPTIONS]\n" +
    options.map{ |(name, desc)|
      if name.end_with?(':')
        name
      else
        sprintf("  %-*s  %-*s", maxn, name, maxd, desc)
      end
    }.join("\n")
  end
end
