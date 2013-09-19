
require 'logi/config'
require 'logi/compiler'

class Logi
  attr_reader :options, :compiler
  def initialize options={}
    @options  = options
    @compiler = Compiler.new(options)
  end

  def make
    config.posts.each_value do |post|
      io = compiler.compile(post.command,
                            config.post_path_for(post),
                            config.layout_path_for(post))

      compiler.write(config.output_path_for(post), io)
    end
  end

  def config
    @config ||= Config.new(options)
  end
end
