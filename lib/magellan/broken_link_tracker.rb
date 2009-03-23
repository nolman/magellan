module Magellan
  class BrokenLinkTracker
    attr_reader :broken_links

    def initialize
      @broken_links = []
    end

    def update(time,result)
      if result.status_code.starts_with?("5") || result.status_code.starts_with?("4")
        @broken_links << result
      end
    end

    def has_broken_links?
      !@broken_links.empty?
    end

    def failure_message
      @broken_links.map{|broken_link| "#{broken_link.url} returned #{broken_link.status_code}"}.join("\n")
    end
  end
end
