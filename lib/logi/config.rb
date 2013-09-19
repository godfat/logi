
require 'logi/loader'

class Logi::Config < Struct.new(:post_path, :layout_path,
                                :output_path, :default_layout)
  def self.default_post_path
    'post'
  end

  def self.default_layout_path
    'layout'
  end

  def self.default_output_path
    'public'
  end

  def self.default_layout
    File.expand_path("#{__dir__}/layout/default.html.erb")
  end

  attr_reader :options
  attr_accessor
  def initialize options={}
    @options = options
    Logi::Loader.new(self).load if File.exist?(path)
  end

  def path
    "#{options[:root]}/config/logi.rb"
  end

  def layout_for post
    # layout_path || default_layout ||
    self.class.default_layout
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

  def post_output_path path
    "#{full_output_path}/#{post_name(path)}.html"
  end

  def post_name path
    path.sub("#{full_post_path}/", '').sub(/\..+$/, '')
  end

  def full_post_path
    "#{options[:root]}/#{post_path}"
  end

  def full_output_path
    "#{options[:root]}/#{output_path}"
  end

  def commands
    @commands ||= []
  end
end
