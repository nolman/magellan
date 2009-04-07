module Magellan
  class Logger
    def update(time,passed,message)
      $stdout.putc(passed ? '.' : 'F')
      $stdout.flush
    end
  end
end