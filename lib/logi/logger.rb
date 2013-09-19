
class Logi; end
module Logi::Logger
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
end
