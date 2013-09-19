
require 'logi/logger'

require 'tilt'

require 'cgi'
require 'fileutils'

class Logi; end
class Logi::Compiler
  include Logi::Logger

  attr_reader :options
  def initialize options={}
    @options = options
  end

  def compile command, path, layout
    content = File.read(path).gsub(/\[\[(.+?)(\|(.+?))?\]\]/) do
      %Q{<a href="/#{CGI.escape_html($1)}.html">#{$3 || $1}</a>}
    end
    log_compile(path, layout)
    io = IO.popen("ruby -Ilib -S logi-#{command} #{path} #{layout}", 'r+')
    io.write(content)
    io.close_write
    io
  end

  def write output, io
    log_write(output)
    FileUtils.mkdir_p(File.dirname(output))
    IO.copy_stream(io, output)
  end

  private
  def log_compile path, layout
    log "#{magenta("Compiling  #{strip_path(path)}")} with\n" \
        "   layout: #{strip_path(layout)}"
  end

  def log_write path
    log green("Writing to #{strip_path(path)}")
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
