
require 'logi/logger'

require 'fileutils'

class Logi; end
class Logi::Compiler
  include Logi::Logger

  attr_reader :options
  def initialize options={}
    @options = options
  end

  def compile command, path, layout
    wiki = IO.popen("logi-wiki #{path}", 'r')
    out  = IO.popen("logi-#{command} #{path} #{layout}", 'r+')
    IO.copy_stream(wiki, out)
    out.close_write
    log_compile(command, path, layout) unless out.eof?
    out
  end

  def write output, out
    return if out.eof?
    log_write(output)
    FileUtils.mkdir_p(File.dirname(output))
    IO.copy_stream(out, output)
  ensure
    out.close
  end

  private
  def log_compile command, path, layout
    w = red('logi-wiki')
    c = red("logi-#{command}")
    p = magenta(strip_path(path))
    l = yellow(strip_path(layout))
    log "#{w} #{p} |\n#{c} #{p} #{l}"
  end

  def log_write path
    log "> #{green(strip_path(path))}"
  end
end
