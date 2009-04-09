require 'activesupport'
require 'observer'

module Magellan
  # An instance of the Cartographer class maps a set of domains from a given starting url
  # every time a new response is received the cartographer updates any observers listening to it
  # to subscribe to the updates:
  # cartographer = Cartographer.new({})
  # cartographer.add_observer(some_observer_instance) 
  #
  # Your observer instance should implement a update(time,result) method that takes in the current time and a Magellan::Result from the crawl
  class Cartographer
    include Observable

    # Create a new Cartographer with a hash of settings:
    # [:origin_url] - where to start exploring
    # [:ignored_urls] - an array of absolute urls to not explore
    # [:domains] - domains we should crawl
    # [:depth_to_explore] - how deep to explore
    # [:links_we_want_to_explore] - the kind of resources we will follow ex: //a[@href]
    # [:trace] - enable a step by step trace
    def initialize(settings)
      @origin_url = settings[:origin_url]
      @known_urls = settings[:ignored_urls]
      @domains = settings[:domains].map {|domain| URI.parse(domain)}
      @depth_to_explore = settings[:depth_to_explore]
      @links_we_want_to_explore = settings[:links_to_explore]
      @trace = settings[:trace]
    end

    # Start recursivily exploring the site at the origin url you specify.
    def crawl
      recursive_explore([@origin_url],1)
    end

    # Recursivily explore a list or urls until you reach a given depth or run out of known urls
    def recursive_explore(urls,depth)
      if i_am_not_too_deep?(depth)
        $stdout.puts "\nexploring:\n#{urls.join("\n")}" if @trace
        results = Explorer.new(urls,@links_we_want_to_explore).explore
        results.each do |result|
          changed
          notify_observers(Time.now, result)
          @known_urls << result.url.remove_fragment
          @known_urls << result.destination_url.remove_fragment
          remove_javascript_and_print_warning result
        end

        all_urls = results.map {|result| result.absolute_linked_resources }.flatten
        all_urls.uniq!
        #TODO: handle any other url parsing error
        all_urls.delete_if { |url| !a_domain_we_care_about?(url)}
        all_urls.delete_if { |url| i_have_seen_this_url_before?(url)}
        all_urls.chunk(40).each do |result_chunk|
          recursive_explore(result_chunk,depth+1)
        end
      end
    end

    # Has the cartographer seen this url before?
    def i_have_seen_this_url_before?(url) 
      @known_urls.include?(url.remove_fragment)
    end
    
    # Should we keep exploring this depth?
    def i_am_not_too_deep?(depth)
      depth <= @depth_to_explore
    end

    # Is a given url in a domain that we care about?
    def a_domain_we_care_about?(url)
      begin
        !@domains.select { |domain| URI.parse(url).host == domain.host }.empty?
      rescue
        !@domains.select { |domain| url.gsub(/https*:\/\//,'').starts_with?(domain.host) }.empty?
      end
    end

    # Remove the javascript links from the set of links on the page.
    def remove_javascript_and_print_warning(result)
      #TODO: put this in the logger
      result.linked_resources.delete_if { |linked_resource| linked_resource.downcase.starts_with?("javascript:") }
    end

  end
end
