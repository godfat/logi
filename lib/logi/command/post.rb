
require 'logi/default'
require 'logi/logger'

require 'tilt'

class  Logi         ; end
module Logi::Command; end
module Logi::Command::Post
  extend Logi::Logger

  module_function
  def run argv
    path, layout = argv.map(&:dup)
    check(path, layout)
    puts Tilt.new(layout).render{Tilt[path].new{$stdin.read}.render}
  end

  def check path, layout
    unless File.exist?(path)
      log red("ERROR: Post does not exist: #{cyan(strip_path(path))}")
      exit(1)
    end

    unless File.exist?(layout)
      log red("WARN: Layout does not exist: #{cyan(strip_path(layout))}")
      layout.replace(Logi::Default.empty_layout)
    end
  end

  def options
    @options ||= {:quiet   => tribool(ENV['LOGI_QUIET'  ]),
                  :nocolor => tribool(ENV['LOGI_NOCOLOR'])}
  end

  def tribool value
    case value
    when 'true'
      true
    when 'false'
      false
    else
      nil
    end
  end
end
