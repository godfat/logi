
begin
  require "#{dir = File.dirname(__FILE__)}/task/gemgem"
rescue LoadError
  sh 'git submodule update --init'
  exec Gem.ruby, '-S', $PROGRAM_NAME, *ARGV
end

Gemgem.init(dir) do |s|
  require 'logi/version'
  s.name    = 'logi'
  s.version = Logi::VERSION
  %w[].each{ |g| s.add_dependency(g) }
  %w[bacon muack
     tilt kramdown].each{ |g| s.add_development_dependency(g) }
end
