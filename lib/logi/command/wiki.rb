
require 'cgi'

class  Logi         ; end
module Logi::Command; end
module Logi::Command::Wiki
  module_function
  def run argv
    puts File.read(argv.first).gsub(/\[\[(.+?)(\|(.+?))?\]\]/){
      %Q{<a href="/#{CGI.escape_html($1)}.html">#{$3 || $1}</a>}
    }
  end
end
