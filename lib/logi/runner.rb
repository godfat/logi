
require 'logi'

module Logi::Runner
  module_function
  def options
  end

  def run argv=ARGV
    require 'cgi'
    post = 'example/post/about.md'
    content = File.read(post).gsub(/\[\[(.+?)(\|(.+?))?\]\]/) do
      %Q{<a href="/#{CGI.escape_html($1)}.html">#{$3 || $1}</a>}
    end
    require 'tilt'
    puts Tilt.new('example/layout/index.html.erb').
           render{Tilt[post].new{content}.render}
  end

  def parse argv
  end

  def help
    maxn = options.transpose.first.map(&:size).max
    maxd = options.transpose.last .map(&:size).max
    "Usage: logi [OPTIONS]\n" +
    options.map{ |(name, desc)|
      if name.end_with?(':')
        name
      else
        sprintf("  %-*s  %-*s", maxn, name, maxd, desc)
      end
    }.join("\n")
  end
end
