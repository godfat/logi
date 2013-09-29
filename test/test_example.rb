
require 'logi/test'

describe Logi do
  logi = Logi.new(:root => "#{__dir__}/../example")
  conf = logi.config
  comp = logi.compiler

  after do
    Muack.verify
  end

  should 'make' do
    mock(comp).write(is_a(String), is_a(IO)){ |path, io|
      File.read(path).should.eq(io.read)
    }.times(conf.posts.size)

    logi.make
  end
end
