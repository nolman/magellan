require 'activesupport'
require 'observer'

module Magellan
  class Cartographer
    include Observable

    def initialize(origin_url, depth_to_explore = 5, domains = [origin_url])
      @origin_url = origin_url
      @known_urls = {}
      @domains = domains.map {|domain| URI.parse(domain)}
      @depth_to_explore = depth_to_explore
    end

    def crawl
      recursive_explore(@origin_url,1)
    end
    
    def recursive_explore(url,depth)
      if i_have_not_seen_this_url_yet?(url) && a_domain_we_care_about?(url) && i_am_not_too_deep?(depth)
        result = Explorer.new(url).explore
        changed
        notify_observers(Time.now, result)
        @known_urls[url] = nil
        result.linked_resources.each do |linked_resource|
          recursive_explore(linked_resource, depth+1)
        end
      end
    end

    def i_have_not_seen_this_url_yet?(url)
      !@known_urls.include?(url)
    end

    def i_am_not_too_deep?(depth)
      depth <= @depth_to_explore
    end

    def a_domain_we_care_about?(url)
      !@domains.select { |domain| URI.parse(url).host == domain.host }.empty?
    end
  end
end
