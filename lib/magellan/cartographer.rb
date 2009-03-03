module Magellan
  class Cartographer
    def initialize(origin_url)
      @origin_url = origin_url
      @known_urls = {}
    end

    def crawl
      recursive_explore(@origin_url)
    end

    def recursive_explore(url)
      if !@known_urls.include?(url)
        result = Explorer.new.explore(url)
        @known_urls[url] = nil
        result.linked_resources.each do |linked_resource|
          recursive_explore(linked_resource)
        end
      end
    end
  end
end
