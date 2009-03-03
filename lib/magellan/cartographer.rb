module Magellan
  class Cartographer
    def initialize(origin_url)
      @origin_url = origin_url
    end
    
    def crawl
      Explorer.new.explore(@origin_url)
    end
  end
end
