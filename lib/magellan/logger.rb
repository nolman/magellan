module Magellan
  class Logger
    def initialize(file_name=nil)
      @file_name = file_name
    end
    
    def update(time,passed,message)
      $stdout.putc(passed ? '.' : 'F')
      $stdout.flush
      if @file_name
        File.open(@file_name, 'a') {|f| f.write(message + "\n") }
      end
    end
  end
end