
require 'logi/config'
require 'logi/compiler'

class Logi
  attr_reader :options, :compiler
  def initialize options={}
    @options  = options
    @compiler = Compiler.new(options)
  end

  def make
    posts.each do |path, layout|
      compiler.write(config.post_output_path(path),
                     compiler.compile(path, layout))
    end
  end

  def posts
    @posts ||= Dir["#{config.full_post_path}/**/*.*"].inject({}) do |r, path|
      r[path] = config.layout_for(path)
      r
    end
  end

  def config
    @config ||= Config.new(options)
  end
end
