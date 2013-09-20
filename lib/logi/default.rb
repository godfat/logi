
class Logi; end
module Logi::Default
  module_function
  def default_root_path  ; '.'     ; end
  def default_post_path  ; 'post'  ; end
  def default_layout_path; 'layout'; end
  def default_output_path; 'public'; end
  def default_command    ; 'post'  ; end
  def default_layout
    File.expand_path("#{__dir__}/layout/default.html.erb")
  end
  def empty_layout
    File.expand_path("#{__dir__}/layout/empty.html.erb")
  end
end
