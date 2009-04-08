module Magellan
  class Logger
    def initialize(file_name=nil)
      @file_name = file_name
      File.open(@file_name, 'a') {} if @file_name
    end
    
    def update(time,passed,message) # :foo:
      $stdout.putc(passed ? '.' : 'F')
      $stdout.flush
      File.open(@file_name, 'a') {|f| f.write(message + "\n") } if @file_name && !passed
    end
    
    def f
      
    end
  end
end