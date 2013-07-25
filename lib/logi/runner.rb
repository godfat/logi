
require 'logi'

module Logi::Runner
  module_function
  def options
  end

  def run argv=ARGV
    post = 'example/post/about.md'
    content = File.read(post).gsub(/\[\[(.+?)(\|(.+?))?\]\]/) do
      %Q{<a href="/#{$1}">#{$3 || $1}</a>}
    end
    require 'kramdown'
    require 'erb'
    require 'tilt'
    puts Tilt.new('example/layout/index.html.erb').
           render{Tilt[post].new{content}.render}
  end

  def parse argv
  end

  def help
    maxn = options.transpose.first.map(&:size).max
    maxd = options.transpose.last .map(&:size).max
    "Usage: saya [ruby OPTIONS] [saya OPTIONS]\n" +
    options.map{ |(name, desc)|
      if name.end_with?(':')
        name
      else
        sprintf("  %-*s  %-*s", maxn, name, maxd, desc)
      end
    }.join("\n")
  end
end
