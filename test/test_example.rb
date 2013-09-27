
require 'logi/test'

describe Logi do
  logi = Logi.new(:root => "#{__dir__}/../example")
  conf = logi.config
  comp = logi.compiler

  should 'make' do
    conf.posts.each_value do |post|
      io = comp.compile(post.command,
                        conf.post_path_for(post),
                        conf.layout_path_for(post))

      File.read(conf.output_path_for(post)).should.eq io.read
    end
  end
end
