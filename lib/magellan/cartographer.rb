module Magellan
  class Cartographer

    def initialize(origin_url, depth_to_explore = 5, domains = [origin_url])
      @origin_url = URI.parse(origin_url)
      @known_urls = {}
      @domains = domains.map {|domain| URI.parse(domain).host}
      @depth_to_explore = depth_to_explore
    end

    def crawl
      recursive_explore(@origin_url,1)
    end

    def recursive_explore(url,depth)
      if should_crawl_this_url?(url) && i_am_not_too_deep?(depth)
        result = Explorer.new.explore(url)
        @known_urls[url] = nil
        result.linked_resources.each do |linked_resource|
          recursive_explore(linked_resource, depth+1)
        end
      end
    end

    def should_crawl_this_url?(uri)
      i_have_not_seen_this_url_yet?(uri) && a_domain_we_care_about?(uri)
    end
    
    def i_have_not_seen_this_url_yet?(uri)
      !@known_urls.include?(uri)
    end
    
    def i_am_not_too_deep?(depth)
      depth <= @depth_to_explore
    end

    def a_domain_we_care_about?(uri)
      @domains.include?(uri.host)
    end
  end
end
