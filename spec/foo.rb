require 'rubygems'
require 'open-uri'
require 'spec_helper'

require 'magellan'
require 'mechanize'

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


agent = WWW::Mechanize.new
stack = agent.get("http://www.gap.com/browse/category.do?cid=40239").links
puts stack
