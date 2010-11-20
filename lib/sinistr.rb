require "#{File.dirname(__FILE__)}/sinistr/sinistr.rb"
#
# Sinister.
#


if __FILE__ == $0
  Sinistr::Sinistr.do_process(ARGV)
end
