require 'open-uri'
require 'spec_helper'
require 'magellan'
def async_request_urls(urls = [])
  reqs = []
  urls.each do |url|
    reqs << Thread.new { open(url) }
  end
  reqs.collect { |req| req.value }
end

def sync_request_urls(urls)
  urls.map {|url| open(url)}
end

#urls = [ 'http://www.blahr.com/', 'http://www.news.com/','http://www.news.com/','http://www.news.com/','http://www.google.com','http://www.google.com' ,'http://www.google.com' ,'http://www.google.com'  ]
#responses = sync_request_urls  urls

#puts urls.size
#puts responses.size
 cartographer = Magellan::Cartographer.new("http://www.thoughtworks.com",5)
  broken_link_tracker = Magellan::BrokenLinkTracker.new
  cartographer.add_observer(broken_link_tracker)
  cartographer.crawl
  if broken_link_tracker.has_broken_links?
    STDERR.puts broken_link_tracker.failure_message
    raise "#{@name} failed while exploring"
  end