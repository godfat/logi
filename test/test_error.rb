
require 'logi/test'
require 'tempfile'

describe Logi do
  logi = Logi.new
  conf = logi.config
  comp = logi.compiler
  post = Logi::Post.new('post', 'post.md', {})

  after do
    Muack.verify
  end

  should 'show an error if the post does not exist' do
    $stderr.reopen(Tempfile.new('stderr'))
    mock(conf).posts{ {'path' => post} }

    logi.make
    File.should.not.exist?(conf.output_path_for(post))

    $stderr.rewind
    $stderr.read.gsub(/\e\[\d+m/, '').should.eq \
      "ERROR: Post does not exist: ./post/post.md\n"
  end
end
