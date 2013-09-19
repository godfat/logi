
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
    log_compile(command, path, layout)
    io = IO.popen("logi-#{command} #{path} #{layout}", 'r+')
    io.write(content)
    io.close_write
    io
  end

  def write output, io
    log_write(output)
    FileUtils.mkdir_p(File.dirname(output))
    IO.copy_stream(io, output)
  ensure
    io.close
  end

  private
  def log_compile command, path, layout
    c = red("logi-#{command}")
    p = magenta(strip_path(path))
    l = yellow(strip_path(layout))
    log "#{c} #{p} #{l}"
  end

  def log_write path
    log "> #{green(strip_path(path))}"
  end
end
