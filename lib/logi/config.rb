
class Logi::Config
  def self.default_layout
    File.expand_path("#{__dir__}/layout/default.html.erb")
  end

  def self.default_post_path
    'post'
  end

  def self.default_output_path
    'public'
  end

  attr_reader :root
  def initialize root
    @root = root
  end

  def layout
    {}
  end

  def [] name
    nil
  end
end
