
require 'logi/command'

require 'tilt'

class  Logi         ; end
module Logi::Command; end
module Logi::Command::Post
  extend Logi::Command

  module_function
  def run argv
    path, layout = check_argv(*argv)
    puts Tilt.new(layout).render{Tilt[path].new{$stdin.read}.render}
  end
end
