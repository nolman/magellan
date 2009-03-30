require 'hpricot'
require 'open-uri'
require 'ostruct'

module Magellan
  class Explorer

    def initialize(urls)
      @urls = urls
    end

    def explore
      reqs = []
      @urls.each do |url|
        reqs.push Thread.new { explore_a(url) }
      end
      reqs.collect { |req| req.value }
    end

    def explore_a(url)
      begin
        agent = WWW::Mechanize.new
        agent.user_agent = "Ruby/#{RUBY_VERSION}"
        doc = agent.get(url) 
        destination_url = doc.uri.to_s
        status_code = doc.code
        if doc.respond_to?(:content_type) && doc.content_type.starts_with?("text/html")
          Explorer.create_result(url, destination_url, status_code, doc.links_to_other_documents)
        else
          Explorer.create_result(url, destination_url, status_code, [])
        end
      rescue WWW::Mechanize::ResponseCodeError => the_error
        Explorer.create_result(url, url, the_error.response_code, [])
      end
    end

    def self.create_result(url,destination_url,status_code,links)
      absolute_links = links.map { |linked_resource| linked_resource.to_s.to_absolute_url(destination_url) }.compact
      OpenStruct.new({:status_code => status_code, :linked_resources => absolute_links, :url => url, :destination_url => destination_url})
    end
  end
end
