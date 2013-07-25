# encoding: utf-8

begin
  require "#{dir = File.dirname(__FILE__)}/task/gemgem"
rescue LoadError
  sh "git submodule update --init"
  exec Gem.ruby, "-S", "rake", *ARGV
end

Gemgem.dir = dir
($LOAD_PATH << File.expand_path("#{Gemgem.dir}/lib")).uniq!

desc 'Generate gemspec'
task 'gem:spec' do
  Gemgem.spec = Gemgem.create do |s|
    require 'logi/version'
    s.name    = 'logi'
    s.version = Logi::VERSION
    %w[tilt].each{ |g| s.add_dependency(g) }
    %w[bacon muack].each{ |g| s.add_development_dependency(g) }
  end

  Gemgem.write
end
