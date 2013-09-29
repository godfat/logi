
require 'logi/test'
require 'tempfile'

describe Logi do
  logi = Logi.new
  conf = logi.config
  comp = logi.compiler
  post = Logi::Post.new('post', 'post.md')
  list = Logi::Post.new('list', 'list', :layout => 'bad')

  after do
    Muack.verify
  end

  should 'show an error if the post does not exist' do
    $stderr.reopen(Tempfile.new('stderr'), 'r+')
    mock(conf).posts{ {'path' => post} }

    logi.make
    File.should.not.exist?(conf.output_path_for(post))

    $stderr.rewind
    $stderr.read.gsub(/\e\[\d+m/, '').should.eq \
      "ERROR: Post does not exist: ./post/post.md\n"
  end

  should 'warn if the layout does not exist' do
    $stderr.reopen(Tempfile.new('stderr'), 'r+')
    mock(conf).posts{ {'path' => list} }

    logi.make
    path = conf.output_path_for(list)
    File.should.exist?(path)

    $stderr.rewind
    $stderr.read.gsub(/\e\[\d+m/, '').should.eq <<-MESSAGE
WARN: Layout does not exist: ./layout/bad
WARN: Fallback to the default: ./lib/logi/layout/default.html.erb
logi-wiki ./post/list |
logi-list ./post/list ./layout/bad
> ./public/list.html
    MESSAGE

    File.delete(conf.output_path_for(list))
  end
end
