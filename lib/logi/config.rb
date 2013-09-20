
require 'logi/default'
require 'logi/loader'

class Logi; end
class Logi::Config < Struct.new(:post_path, :layout_path,
                                :output_path, :default_layout)
  attr_reader :options
  attr_accessor
  def initialize options={}
    @options = options
    Logi::Loader.new(self).load if File.exist?(path)
  end

  def posts
    @posts ||= {}
  end

  def root
    options[:root] || Logi::Default.default_root_path
  end

  def path
    "#{root}/config/logi.rb"
  end

  def post_path_for post
    "#{root}/#{post_path}/#{post.path}"
  end

  def layout_path_for post
    if layout = post.options[:layout] || default_layout
      "#{root}/#{layout_path}/#{layout}"
    else
      Logi::Default.default_layout
    end
  end

  def output_path_for post
    "#{root}/#{output_path}/#{post.path.sub(/\..+$/, '')}.html"
  end

  def post_path
    super || Logi::Default.default_post_path
  end

  def layout_path
    super || Logi::Default.default_layout_path
  end

  def output_path
    super || Logi::Default.default_output_path
  end
end
