
require 'logi/post'

class Logi; end
class Logi::Loader
  attr_reader :config
  def initialize config
    @config = config
  end

  def load
    instance_eval(File.read(config.path))
    prefix = "#{config.root}/#{config.post_path}"
    Dir["#{prefix}/**/*.*"].each do |fullpath|
      path = fullpath.sub("#{prefix}/", '')
      config.posts[path] ||=
        Logi::Post.new(config.class.default_command, path, {}, nil)
    end
  end

  def post_path path
    config.post_path = path
  end

  def layout_path path
    config.layout_path = path
  end

  def output_path path
    config.output_path = path
  end

  def layout path
    config.default_layout = path
  end

  def method_missing cmd, *args, &block
    path, options = args[0], args[1]
    config.posts[path] = Logi::Post.new(cmd, path, options, block)
  end
end
