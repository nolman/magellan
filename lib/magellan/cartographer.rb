require 'activesupport'

module Magellan
  class Cartographer
    #if we use the observer pattern for a new result we can change this to broadcast a new result
    attr_reader :broken_links

    def initialize(origin_url, depth_to_explore = 5, domains = [origin_url])
      @origin_url = origin_url
      @known_urls = {}
      @broken_links = []
      @domains = domains
      @depth_to_explore = depth_to_explore
    end

    def crawl
      recursive_explore(@origin_url,1)
    end
    
    def recursive_explore(url,depth)
      if should_crawl_this_url?(url) && i_am_not_too_deep?(depth)
        result = Explorer.new.explore(url)
        @known_urls[url] = nil
        record_link_if_broken(result)
        result.linked_resources.each do |linked_resource|
          recursive_explore(linked_resource, depth+1)
        end
      end
    end

    def should_crawl_this_url?(url)
      i_have_not_seen_this_url_yet?(url) && a_domain_we_care_about?(url)
    end

    def i_have_not_seen_this_url_yet?(url)
      !@known_urls.include?(url)
    end

    def i_am_not_too_deep?(depth)
      depth <= @depth_to_explore
    end

    def a_domain_we_care_about?(url)
      !@domains.select { |domain| url.starts_with?(domain) }.empty?
    end
    
    #this method will likely belong in another class
    def record_link_if_broken(result)
      if result.status_code.starts_with?("5") || result.status_code.starts_with?("4")
        @broken_links << result
      end
    end
    
    def has_broken_links?
      !@broken_links.empty?
    end
    
    def failure_message
      @broken_links.join("\n")
    end
    
  end
end
