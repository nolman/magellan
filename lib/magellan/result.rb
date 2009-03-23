module Magellan
  class Result
    attr_reader :url, :status_code
    def initialize(url,status_code)
      @url = url
      @status_code = status_code
    end
    def to_s
      "#{url} responded with: #{status_code}"
    end
    def eql?(other)
      @url==other
    end
  end
end