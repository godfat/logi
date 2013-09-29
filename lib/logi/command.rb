
class Logi; end
module Logi::Command
  module_function
  def command
    name[/[^:]+$/].downcase
  end

  def check_argv path, layout
    [check_path(path), check_path(layout)]
  end

  def check_path path
    if File.exist?(path)
      path
    else
      require 'logi/logger'
      extend Logi::Logger
      log red("ERROR: Post does not exist: #{cyan(strip_path(path))}")
      exit(1)
    end
  end

  def check_layout layout
    if File.exist?(layout)
      layout
    else
      require 'logi/default'
      require 'logi/logger'
      extend Logi::Logger
      log red("WARN: Layout does not exist: #{cyan(strip_path(layout))}")
      default = Logi::Default.layout_for(command)
      log red("WARN: Fallback to the default: #{cyan(strip_path(default))}")
      default
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
