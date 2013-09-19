
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
    log "#{magenta("Compiling  #{strip_path(path)}")} with\n" \
        "   layout: #{strip_path(layout)}"
  end

  def log_write path
    log green("Writing to #{strip_path(path)}")
  end

  def log msg
    return if options[:quiet]
    puts msg
  end

  def   black text; color(30, text); end
  def     red text; color(31, text); end
  def   green text; color(32, text); end
  def  yellow text; color(33, text); end
  def    blue text; color(34, text); end
  def magenta text; color(35, text); end
  def    cyan text; color(36, text); end
  def   white text; color(37, text); end
  def color rgb, text
    if nocolor = options[:nocolor]
      text
    elsif nocolor.nil? && !$stdout.tty? # auto-detect
      text
    else
      "\e[#{rgb}m#{text}\e[0m"
    end
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
