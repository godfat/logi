
class Logi; end
module Logi::Runner
  module_function
  def options
    @options ||=
    [['-c, --color'      , '   Color mode (default)'],
     ['-n, --no-color'   , 'No color mode'          ],
     ['-V, --verbose'    , ' Verbose mode (default)'],
     ['-q, --quiet'      , '   Quiet mode'          ],
     ['-h, --help'       , 'Print this message'     ],
     ['-v, --version'    , 'Print the version'      ]]
  end

  def run argv=ARGV
    options = parse(argv)
    require 'logi' # lazily load logi since we might exit earlier
    Logi.new(options).make
  end

  def parse argv
    options = {}
    until argv.empty?
      case arg = argv.shift
      when /^-c/, '--color'
        options[:nocolor] = false
        parse_next(argv, arg)

      when /^-n/, '--no-color'
        options[:nocolor] = true
        parse_next(argv, arg)

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
        options[:root] = File.expand_path(arg)
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
