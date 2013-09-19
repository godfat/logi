
class Logi; end
module Logi::Runner
  module_function
  def options
    @options ||=
    [['-V, --verbose'    , 'Verbose mode (default)'],
     ['-q, --quiet'      , 'Quiet   mode'          ],
     ['-h, --help'       , 'Print this message'    ],
     ['-v, --version'    , 'Print the version'     ]]
  end

  def run argv=ARGV
    require 'logi'
    opts = parse(argv)
    root = opts.delete(:root)
    Logi.new(root || '.', opts).make
  end

  def post argv=ARGV
    require 'logi/command/post'
  end

  def list argv=ARGV
    require 'logi/command/list'
  end

  def parse argv
    options = {}
    until argv.empty?
      case arg = argv.shift
      when /^-V/, '--verbose'
        options[:quiet] = false
        parse_next(argv, arg)

      when /^-q/, '--quiet'
        options[:quiet] = true
        parse_next(argv, arg)

      when /^-h/, '--help'
        puts(help)
        exit

      when /^-v/, '--version'
        require 'rib/version'
        puts(Rib::VERSION)
        exit

      else
        options[:root] = arg
      end
    end
    options
  end

  def parse_next argv, arg
    argv.unshift("-#{arg[2..-1]}") if arg.size > 2
  end

  def help
    maxn = options.transpose.first.map(&:size).max
    maxd = options.transpose.last .map(&:size).max
    "Usage: logi [OPTIONS] [PATH to logi root]\n" +
    options.map{ |(name, desc)|
      sprintf("  %-*s  %-*s", maxn, name, maxd, desc)
    }.join("\n")
  end
end
