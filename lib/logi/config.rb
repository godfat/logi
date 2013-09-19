
require 'logi/loader'

class Logi; end
class Logi::Config < Struct.new(:post_path, :layout_path,
                                :output_path, :default_layout)
  def self.default_root_path  ; '.'     ; end
  def self.default_post_path  ; 'post'  ; end
  def self.default_layout_path; 'layout'; end
  def self.default_output_path; 'public'; end
  def self.default_command    ; 'post'  ; end
  def self.default_layout
    File.expand_path("#{__dir__}/layout/default.html.erb")
  end

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
    options[:root] || self.class.default_root_path
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
      self.class.default_layout
    end
  end

  def output_path_for post
    "#{root}/#{output_path}/#{post.path.sub(/\..+$/, '')}.html"
  end

  def post_path
    super || self.class.default_post_path
  end

  def layout_path
    super || self.class.default_layout_path
  end

  def output_path
    super || self.class.default_output_path
  end
end
