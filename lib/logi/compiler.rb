
require 'tilt'

require 'fileutils'
require 'cgi'

class Logi::Compiler
  attr_reader :options
  def initialize options={}
    @options = options
  end

  def compile path, layout
    content = File.read(path).gsub(/\[\[(.+?)(\|(.+?))?\]\]/) do
      %Q{<a href="/#{CGI.escape_html($1)}.html">#{$3 || $1}</a>}
    end
    log_compile(path, layout)
    Tilt.new(layout).render{Tilt[path].new{content}.render}
  end

  def write output, content
    log_write(output)
    FileUtils.mkdir_p(File.dirname(output))
    File.write(output, content)
  end

  private
  def log_compile path, layout
    log "Compiling #{strip_path(path)} with #{strip_path(layout)}"
  end

  def log_write path
    log "Writing to #{strip_path(path)}"
  end

  def log msg
    return if options[:quiet]
    puts msg
  end

  def strip_path path
    strip_home_path(strip_cwd_path(path))
  end

  def strip_home_path path
    path.sub(ENV['HOME'], '~')
  end

  def strip_cwd_path path
    path.sub(Dir.pwd, '.')
  end
end
