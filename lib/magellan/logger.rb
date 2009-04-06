module Magellan
  class Logger
    def update(time,result)
      $stdout.putc(result ? '.' : 'F')
      $stdout.flush
    end
  end
end