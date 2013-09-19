
class Logi; end
module Logi::Runner
  module_function
  def options
    @options ||=
    [['logi options:'    , ''                       ],
     ['-c, --color'      , '   Color mode (default)'],
     ['-n, --no-color'   , 'No color mode'          ],
     ['-V, --verbose'    , ' Verbose mode (default)'],
     ['-q, --quiet'      , '   Quiet mode'          ],
     ['-h, --help'       , 'Print this message'     ],
     ['-v, --version'    , 'Print the version'      ],
     ['defaults:'        , ''                       ],
     ['  root directory' , Logi::Config.  default_root_path],
     ['  post directory' , Logi::Config.  default_post_path],
     ['layout directory' , Logi::Config.default_layout_path],
     ['output directory' , Logi::Config.default_output_path],
     ['    post command' , Logi::Config.default_command    ],
     ['     layout file' , Logi::Logger.strip_path(
                             Logi::Config.default_layout)  ]]
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
    require 'logi/config'
    require 'logi/logger'
    optt = options.transpose
    maxn = optt.first.map(&:size).max
    maxd = [optt.last .map(&:size).max, `tput cols`.to_i - maxn - 4].min
    "Usage: logi [OPTIONS] [PATH to logi root]\n" +
    options.map{ |(name, desc)|
      if name.end_with?(':')
        name
      else
        sprintf("  %-*s  %-*s", maxn, name, maxd, desc)
      end
    }.join("\n")
  end
end
