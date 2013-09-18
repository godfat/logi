
class Logi::Config
  class Loader
    attr_reader :config
    def initialize config
      @config = config
    end

    def load
      instance_eval(File.read(config.path))
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
      config.commands << [cmd, args, block]
    end
  end

  def self.default_layout
    File.expand_path("#{__dir__}/layout/default.html.erb")
  end

  def self.default_post_path
    'post'
  end

  def self.default_output_path
    'public'
  end

  attr_reader :root
  attr_accessor :post_path, :layout_path, :output_path, :default_layout
  def initialize root
    @root = root
    Loader.new(self).load if File.exist?(path)
  end

  def path
    "#{root}/config/logi.rb"
  end

  def layout
    {}
  end

  def [] name
    nil
  end

  def commands
    @commands ||= []
  end
end
