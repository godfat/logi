
require 'logi/command'

require 'tilt'

class  Logi         ; end
module Logi::Command; end
module Logi::Command::List
  extend Logi::Command

  class Post < Struct.new(:link, :title)
    def <=> that
      link <=> that.link
    end
  end

  module_function
  def run argv
    path, layout = argv
    dir = File.dirname(path)
    @posts = Dir["#{dir}/**/*.*"].map{ |post|
      name = post.sub("#{dir}/", '')
      Post.new(name.sub(/\..+$/, '.html'), name.sub(/\..+$/, ''))
    }.sort
    puts Tilt.new(check_layout(layout)).render(self){
      '<ul>' + @posts.map{ |post|
                 "<li><a href=\"#{post.link}\">#{post.title}</a></li>"
               }.join("\n") +
      '</ul>'
    }
  end
end
