
require 'tilt'

class  Logi         ; end
module Logi::Command; end
module Logi::Command::List
  Post = Struct.new(:link, :title)

  module_function
  def run argv
    path, layout = argv
    dir = File.dirname(path)
    @posts = Dir["#{dir}/**/*.*"].map{ |post|
      name = post.sub("#{dir}/", '')
      Post.new(name.sub(/\..+$/, '.html'), name.sub(/\..+$/, ''))
    }
    puts Tilt.new(layout).render(self)
  end
end
