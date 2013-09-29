
require 'logi/test'

describe Logi do
  logi = Logi.new(:root => "#{File.dirname(__FILE__)}/../example")
  conf = logi.config
  comp = logi.compiler

  after do
    Muack.verify
  end

  should 'make' do
    logs = []
    stub(comp).log(is_a(String)){ |msg| logs << "#{msg}\n" }

    mock(comp).write(is_a(String), is_a(IO)){ |path, io|
      File.read(path).should.eq(io.read)
    }.times(conf.posts.size)

    logi.make

    logs.join.gsub(/\e\[\d+m/, '').should.eq <<-MESSAGE
logi-wiki ./example/post/hello.md |
logi-post ./example/post/hello.md ./example/layout/another.html.erb
logi-wiki ./example/post/list |
logi-list ./example/post/list ./example/layout/list.html.erb
logi-wiki ./example/post/index.md |
logi-post ./example/post/index.md ./example/layout/default.html.erb
logi-wiki ./example/post/misc/about.md |
logi-post ./example/post/misc/about.md ./example/layout/default.html.erb
    MESSAGE
  end
end
