
class Logi; end
class Logi::Post < Struct.new(:command, :path, :options, :block)
  def <=> that
    path <=> that.path
  end

  def options
    super || {}
  end
end
