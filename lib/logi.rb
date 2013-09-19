
require 'logi/config'
require 'logi/compiler'

class Logi
  attr_reader :root, :comp
  def initialize root='.', opts={}
    @root = File.expand_path(root)
    @comp = Compiler.new(opts)
  end

  def make
    contents.each do |path, content|
      @comp.write(post_output_path(path), content)
    end
  end

  def posts
    @posts ||= Dir["#{full_post_path}/**/*.*"].inject({}) do |r, path|
      r[path] = layout_for(path)
      r
    end
  end

  def contents
    @contents ||= posts.inject({}) do |r, (path, layout)|
      r[path] = comp.compile(path, layout)
      r
    end
  end

  def config
    @config ||= Logi::Config.new(root)
  end

  def layout_for post
    config.layout[post]   || Logi::Config.default_layout
  end

  def post_path
    config['post_path']   || Logi::Config.default_post_path
  end

  def output_path
    config['output_path'] || Logi::Config.default_output_path
  end

  def post_output_path path
    "#{full_output_path}/#{post_name(path)}.html"
  end

  def post_name path
    path.sub("#{full_post_path}/", '').sub(/\..+$/, '')
  end

  def full_post_path
    "#{root}/#{post_path}"
  end

  def full_output_path
    "#{root}/#{output_path}"
  end
end
