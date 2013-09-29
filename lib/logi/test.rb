
require 'bacon'
require 'muack'
require 'logi'

Bacon.summary_on_exit
include Muack::API

module Kernel
  def eq? rhs
    self == rhs
  end
end

dir = File.expand_path("#{File.dirname(__FILE__)}/../../")
$LOAD_PATH.unshift("#{dir}/lib")
ENV['RUBYLIB'] = "#{dir}/lib:#{ENV['RUBYLIB']}"
ENV['PATH']    = "#{dir}/bin:#{ENV['PATH']}"
