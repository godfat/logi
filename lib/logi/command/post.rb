
require 'tilt'

class  Logi         ; end
module Logi::Command; end
module Logi::Command::Post
  module_function
  def run argv
    path, layout = argv
    puts Tilt.new(layout).render{Tilt[path].new{$stdin.read}.render}
  end
end
