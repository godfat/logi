
class Logi; end
module Logi::Default
  module_function
  def root_path  ; '.'     ; end
  def post_path  ; 'post'  ; end
  def layout_path; 'layout'; end
  def output_path; 'public'; end
  def command    ; 'post'  ; end
  def layout
    File.expand_path("#{__dir__}/layout/default.html.erb")
  end
  def empty_layout
    File.expand_path("#{__dir__}/layout/empty.html.erb")
  end
  def example_directory
    File.expand_path("#{__dir__}/../../example")
  end

  # For Ruby 1.9-
  def __dir__
    File.dirname(__FILE__)
  end unless respond_to?(:__dir__, true)
end
