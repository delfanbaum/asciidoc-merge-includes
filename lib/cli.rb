require 'optparse'

# CLI for app via `optparse`
class Cli
  # parser for cli
  class Parser
    attr_accessor :in_place, :verbose

    def initialize
      self.in_place = false
      self.verbose = false
    end

    def define_options(parser)
      parser.banner = 'Usage: asciidoc-merge-includes FILE(S) [options]'
      parser.separator ''
      parser.separator 'Options:'

      # Add options
      in_place_option(parser)
      verbose_option(parser)

      parser.separator ''
      parser.separator 'Help options:'
      parser.on_tail('-h', '--help', 'Shows help') do
        puts parser
        exit
      end
    end

    def in_place_option(parser)
      parser.on('-ip', '--in-place', 'Modify asciidoc files in place') do
        self.in_place = true
      end
    end

    def verbose_option(parser)
      parser.on('-v', '--verbose', 'Output processing information') do
        self.verbose = true
      end
    end
  end

  def parse(args)
    @options = Parser.new
    @args = OptionParser.new do |parser|
      @options.define_options(parser)
      parser.parse!(args)
    end
    @options
  end

  attr_reader :parser, :options
end

# simple on/off for verbosity
class Logger
  attr_accessor :verbose

  def initialize(options)
    self.verbose = options.verbose
  end

  def put(message)
    puts message if verbose == true
  end
end
