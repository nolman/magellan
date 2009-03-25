require 'activesupport'
require 'observer'

module Magellan
  class Cartographer
    include Observable

    def initialize(origin_url, depth_to_explore = 5, domains = [origin_url])
      @origin_url = origin_url
      @known_urls = []
      @domains = domains.map {|domain| URI.parse(domain)}
      @depth_to_explore = depth_to_explore
    end

    def crawl
      recursive_explore([@origin_url],1)
    end

    def recursive_explore(urls,depth)
      #      if i_have_not_seen_this_url_yet?(urls) && a_domain_we_care_about?(urls) && i_am_not_too_deep?(depth)
      if i_am_not_too_deep?(depth)
        results = Explorer.new(urls).explore
        changed
        results.each do |result|
          notify_observers(Time.now, result)
        end
#        @known_urls << url.remove_fragment
        results.each do |result|
          result.linked_resources.chunk(40).each do |result_chunk|
            recursive_explore(result_chunk,depth+1)
          end
        end
      end
    end

    def i_have_not_seen_this_url_yet?(url)
      !@known_urls.include?(url.remove_fragment)
    end

    def i_am_not_too_deep?(depth)
      depth <= @depth_to_explore
    end

    def a_domain_we_care_about?(url)
      !@domains.select { |domain| URI.parse(url).host == domain.host }.empty?
    end
  end
end