
require 'logi/config'
require 'logi/compiler'

class Logi
  attr_reader :options, :config, :compiler
  def initialize options={}
    @options  = options
    @config   = Config.new(options)
    @compiler = Compiler.new(options)
  end

  def make
    config.posts.values.sort.each do |post|
      io = compiler.compile(post.command,
                            config.post_path_for(post),
                            config.layout_path_for(post))

      compiler.write(config.output_path_for(post), io)
    end
  end
end
