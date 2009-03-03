module Magellan
  class Cartographer

    def initialize(origin_url, domains = [origin_url])
      @origin_url = URI.parse(origin_url)
      @known_urls = {}
      @domains = domains.map {|domain| URI.parse(domain).host}
    end

    def crawl
      recursive_explore(@origin_url)
    end

    def recursive_explore(url)
      if should_crawl_this_url?(url)
        result = Explorer.new.explore(url)
        @known_urls[url] = nil
        result.linked_resources.each do |linked_resource|
          recursive_explore(linked_resource)
        end
      end
    end

    def should_crawl_this_url?(uri)
      !@known_urls.include?(uri) && a_domain_we_care_about?(uri)
    end

    def a_domain_we_care_about?(uri)
      @domains.include?(uri.host)
    end
  end
end
