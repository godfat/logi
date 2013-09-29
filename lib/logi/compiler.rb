
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
    copy_stream(wiki, out)
    return out if out.eof?
    out.close_write
    log_compile(command, path, layout)
    out
  end

  def write output, out
    return if out.eof?
    log_write(output)
    FileUtils.mkdir_p(File.dirname(output))
    copy_stream(out, output)
  ensure
    out.close unless out.closed?
  end

  def copy_stream from, to
    IO.copy_stream(from, to)
  rescue TypeError # JRuby can only copy from file to file
    to.write(from.read(8192)) until from.eof?
  ensure
    from.close unless from.closed?
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
