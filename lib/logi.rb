
require 'logi/config'

require 'fileutils'
require 'cgi'
require 'tilt'

class Logi
  attr_reader :root
  def initialize root='.'
    @root = File.expand_path(root)
  end

  def make
    contents.each do |path, content|
      output = "#{full_output_path}/#{post_name(path)}.html"
      FileUtils.mkdir_p(File.dirname(output))
      File.write(output, content)
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
      content = File.read(path).gsub(/\[\[(.+?)(\|(.+?))?\]\]/) do
        %Q{<a href="/#{CGI.escape_html($1)}.html">#{$3 || $1}</a>}
      end
      r[path] = Tilt.new(layout).render{Tilt[path].new{content}.render}
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
